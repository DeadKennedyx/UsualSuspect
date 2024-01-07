# frozen_string_literal: true

require_relative "usual_suspect/version"

module UsualSuspect
  class Error < StandardError; end
  # Your code goes here...
  require 'usual_suspect/railtie' if defined?(Rails)
  require 'usual_suspect/user_extension' if defined?(Rails)
end
