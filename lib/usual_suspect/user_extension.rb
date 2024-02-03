module UsualSuspect
  module UserExtension
    extend ActiveSupport::Concern

    def update_login(ip, location, session_token, device_info)
      event = UsualSuspectEvent.new(user: self, session_token: session_token)
      vpn_tor_proxy_usage = UsualSuspect::VpnChecker.check_vpn(ip)

      fingerprint_string = device_info.values.join('|')
      current_fingerprint = Digest::SHA256.hexdigest(fingerprint_string)

      event.assign_attributes(
        sign_in_at: Time.current,
        sign_in_ip: ip,
        city: location.city,
        country: location.country,
        latitude: location.latitude,
        longitude: location.longitude,
        using_vpn: vpn_tor_proxy_usage['security']['vpn'],
        using_proxy: vpn_tor_proxy_usage['security']['proxy'],
        using_tor: vpn_tor_proxy_usage['security']['tor'],
        device_fingerprint: current_fingerprint,
        new_device: usual_suspect_events.none? { |event| event.device_fingerprint == current_fingerprint }
      )

      
      event.save

      check_geo_velocity(event)
    end

    def check_geo_velocity(current_event)
      last_event = UsualSuspectEvent.where(user: self).order(:sign_in_at).second_to_last

      if last_event && geo_velocity_failed?(last_event, current_event)
        current_event.update(geovelocity_failed: true)
      end
    end

    def check_for_suspicious_password_change(session_token)
      event = UsualSuspectEvent.find_by(user: self, session_token: session_token)
      
      if event && event.sign_in_at && Time.current - event.sign_in_at < suspicious_threshold
        log_suspicious_activity('Password changed shortly after login')
        event.update(password_change_after_login: true)
      end
    end

    private

    def geo_velocity_failed?(last_event, current_event)
      distance = Geocoder::Calculations.distance_between(
        [last_event.latitude, last_event.longitude],
        [current_event.latitude, current_event.longitude]
      )

      time_difference_hours = (current_event.sign_in_at - last_event.sign_in_at) / 1.hour

      velocity = distance / time_difference_hours

      max_feasible_velocity = 926

      velocity > max_feasible_velocity
    end

    def suspicious_threshold
      5.minutes
    end

    def log_suspicious_activity(activity)
      Rails.logger.warn("[UsualSuspect] Activity: #{activity}")
    end
  end
end
