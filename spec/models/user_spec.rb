require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) { build_stubbed(:user) }

  describe "attribute specs" do

    it "has an email" do
      expect(user).to respond_to(:email)
    end

    it "has a role" do
      expect(user).to respond_to(:role)
    end

  end

  describe "relation specs" do
    it { should belong_to(:organization).optional }
  end

  describe "attribute validation specs" do

    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255) }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("not an email").for(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(7).is_at_most(255) }

  end

  describe "member function specs" do

    it "has a string representation that is the user's email" do
      email = "test_email@example.com"
      test_user = build_stubbed(:user, email: email)
      expect(test_user.to_s).to eq(email)
    end

    it "sets the default role to the organization" do
      user.set_default_role
      expect(user.role).to eq("organization")
    end

  end

end
