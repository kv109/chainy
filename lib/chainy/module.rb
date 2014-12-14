class Module
  def chain_attr_accessor(symbol, *args)
    if args.last.is_a?(Hash)
      opts = args.pop
    else
      opts = {}
    end

    attr_accessor(symbol, *args)

    prefix = opts[:prefix] || Chainy::Config.prefix

    [].tap do |method_names|
      method_names << symbol
      method_names.concat args
    end.each do |getter_method|
      instance_variable_name = "@#{getter_method}"

      if opts[:hash]
        define_method(getter_method) do
          instance_variable_set instance_variable_name, instance_variable_get(instance_variable_name) || {}
        end
      end

      new_method_name = "#{prefix}_#{getter_method}"

      if opts[:hash]

        define_method(new_method_name) do |hash|
          instance_variable_set instance_variable_name, send(getter_method).merge(hash)
          self
        end

        define_method(:without) do |key|
          send(getter_method).delete(key)
          self
        end

      else

        define_method(new_method_name) do |*args|
          send "#{getter_method}=", *args
          self
        end

      end
    end
  end

  private
end