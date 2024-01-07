module UsualSuspect
  module UserExtension
    extend ActiveSupport::Concern

    included do
      after_update :check_for_suspicious_password_change, if: :saved_change_to_password?
    end

    def update_login_times
      self.last_sign_in_at = self.sign_in_at || Time.current
      self.sign_in_at = Time.current
      save
    end

    private

    def check_for_suspicious_password_change
      if self.last_sign_in_at && Time.current - self.last_sign_in_at < suspicious_threshold
        log_suspicious_activity('Password changed shortly after login')
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
