require 'rails_helper'

RSpec.describe User, type: :model do

  it "exists" do
    user = User.new
    expect(user).to respond_to(:)
  end
end
