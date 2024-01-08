module UsualSuspect
  module UserExtension
    extend ActiveSupport::Concern

    included do
      after_update :check_for_suspicious_password_change, if: :saved_change_to_password?
    end

    def update_login_times
      event = UsualSuspectEvent.find_or_initialize_by(user: self)
      event.last_sign_in_at = event.sign_in_at
      event.sign_in_at = Time.current
      event.save
    end

    private

    def check_for_suspicious_password_change
      event = UsualSuspectEvent.find_by(user: self)
      
      if event && event.sign_in_at && Time.current - event.sign_in_at < suspicious_threshold
        log_suspicious_activity('Password changed shortly after login')
        event.update(password_change_after_login: true)
      end
    end

    def suspicious_threshold
      1.minutes
    end

    def log_suspicious_activity(activity)
      # Implement logging mechanism
      # This could be a simple log, an entry in a database table, or an alert
      Rails.logger.warn("[UsualSuspect] Activity: #{activity}")
    end
  end
end
