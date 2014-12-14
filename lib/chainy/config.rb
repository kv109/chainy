class Chainy::Config
  DEFAULT_CHAIN_METHOD_PREFIX = 'with'

  class << self
    def configure
      yield self if block_given?
    end

    def prefix
      @prefix ||= DEFAULT_CHAIN_METHOD_PREFIX
    end

    def prefix=(prefix)
      @prefix = prefix
    end
  end
end