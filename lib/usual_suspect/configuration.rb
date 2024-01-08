# lib/usual_suspect/configuration.rb
module UsualSuspect
  class Configuration
    attr_accessor :block_criteria

    def initialize
      @block_criteria = []
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
