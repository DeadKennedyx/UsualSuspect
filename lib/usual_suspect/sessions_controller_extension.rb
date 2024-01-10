require 'geocoder'

module UsualSuspect
  module SessionsControllerExtension
    extend ActiveSupport::Concern

    def track_usual_suspect_login
      user_ip = request.remote_ip
      location = Geocoder.search(user_ip).first
      session_token = generate_unique_session_token
      session[:usual_suspect_session_token] = session_token

      current_user.update_login(user_ip, location, session_token) if current_user
    end

    def generate_unique_session_token
      SecureRandom.hex(10)
    end
  end
end
