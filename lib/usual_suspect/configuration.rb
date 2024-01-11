# lib/usual_suspect/configuration.rb
module UsualSuspect
  class Configuration
    attr_accessor :vpn_api_key

    def initialize
      @vpn_api_key = nil
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
