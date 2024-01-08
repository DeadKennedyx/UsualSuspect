module UsualSuspect
  class SecurityEvaluator
    def initialize(user)
      @user = user
      @triggered_indicators = []
    end

    def evaluate
      check_password_change

      # Check if any combination is met
      block_account_if_criteria_met
    end

    private

    def check_password_change
      # Implement password change check
      @triggered_indicators << :password_change_after_login if password_changed_recently
    end

    def block_account_if_criteria_met
      print UsualSuspect.configuration.block_criteria
      UsualSuspect.configuration.block_criteria.each do |criteria|
        if (criteria - @triggered_indicators).empty?
        	return true
        else
        	return false
        end
      end
    end
  end
end
