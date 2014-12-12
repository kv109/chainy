class Module
  def selfie_attr_accessor(symbol, *args)
    if args.last.is_a?(Hash)
      opts = args.pop
    else
      opts = {}
    end

    attr_accessor(symbol, *args)

    prefix = opts[:prefix] || 'with'

    [].tap do |method_names|
      method_names << symbol
      method_names.concat args
    end.each do |method_name|
      new_method_name = "#{prefix}_#{method_name}"
      define_method(new_method_name) do |*args|
        send "#{method_name}=", *args
        self
      end
    end
  end

  private
end