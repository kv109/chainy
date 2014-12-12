class Chainy::Config
  class << self
    def configure
      yield self if block_given?
    end

    def prefix
      @prefix ||= 'with'
    end

    def prefix=(prefix)
      @prefix = prefix
    end
  end
end