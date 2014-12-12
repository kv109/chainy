class Module
  def selfie_attr_accessor(symbol, *args)
    attr_accessor(symbol, *args)

    define_method("with_#{symbol}") do |*args|
      send "#{symbol}=", *args
      self
    end
  end

  private
end