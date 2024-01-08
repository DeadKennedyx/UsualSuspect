module UsualSuspect
  module Event
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      # Add validations and methods as needed
    end

    # Instance methods for event handling
  end
end