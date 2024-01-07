# lib/railtie.rb
require 'usual_suspect'
require 'rails'

module UsualSuspect
  class Railtie < Rails::Railtie
    railtie_name :usual_suspect

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end