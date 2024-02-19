require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "has a name" do
    @res_cat = build_stubbed(:resource_category)
    expect(@res_cat).to respond_to(:name)
  end

end
