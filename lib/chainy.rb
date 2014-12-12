module Chainy
  require_relative 'chainy/config'
  require_relative 'chainy/module'

  def self.configure(&block)
    Chainy::Config.configure(&block)
  end
end
