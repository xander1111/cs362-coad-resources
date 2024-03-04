require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "full_title" do
  
    it "returns the website name when not passed a string" do
      expect(helper.full_title).to eq("Disaster Resource Network")
    end

    it "returns the string given with the website name appended" do
      @page_name = "test page name"
      expect(helper.full_title(@page_name)).to eq(@page_name << " | Disaster Resource Network")
    end

  end

end
