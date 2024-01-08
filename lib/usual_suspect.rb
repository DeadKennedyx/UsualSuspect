# frozen_string_literal: true

require_relative "usual_suspect/version"

module UsualSuspect
  INDICATORS = {
    vpn_usage: 'vpn_usage',
    failed_geo_velocity: 'failed_geo_velocity',
    password_change_after_login: 'password_change_after_login',
  }.freeze
  
  class Error < StandardError; end
  
  Dir[File.dirname(__FILE__) + "/usual_suspect/*.rb"].each {|file| require file }
end
