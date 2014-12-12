class Module
  def selfie_attr_accessor(symbol, *args)
    attr_accessor(symbol, *args)

    [].tap do |method_names|
      method_names << symbol
      method_names.concat args
    end.each do |method_name|
      define_method("with_#{method_name}") do |*args|
        send "#{method_name}=", *args
        self
      end
    end
  end

  private
end