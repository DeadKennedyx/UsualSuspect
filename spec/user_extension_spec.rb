require 'rails_helper'

class User
  include ActiveModel::Model
  include UsualSuspect::UserExtension

  attr_accessor :encrypted_password, :sign_in_at, :last_sign_in_at

  def save
    true
  end

  def encrypted_password_changed?
    !@encrypted_password.nil?
  end
end

RSpec.describe UsualSuspect::UserExtension, type: :model do
  let(:user) { User.new }

  describe "#update_login_times" do
    before { user.update_login_times }

    it "updates sign_in_at to the current time" do
      expect(user.sign_in_at).to be_within(1.second).of(Time.current)
    end

    it "sets last_sign_in_at to the previous sign_in_at value" do
      expect(user.last_sign_in_at).to be_within(1.second).of(Time.current)
    end
  end

  describe "#check_for_suspicious_password_change" do
    context "when password is changed shortly after login" do
      it "logs a suspicious activity" do
        user.sign_in_at = Time.current
        user.last_sign_in_at = user.sign_in_at - 30.seconds
        expect(Rails.logger).to receive(:warn).with("[UsualSuspect] Activity: Password changed shortly after login")
        user.send(:check_for_suspicious_password_change)
      end
    end

    context "when password is not changed shortly after login" do
      it "does not log suspicious activity" do
        user.sign_in_at = Time.current - 2.minutes
        user.last_sign_in_at = user.sign_in_at - 3.minutes
        expect(Rails.logger).not_to receive(:warn)
        user.send(:check_for_suspicious_password_change)
      end
    end
  end
end
