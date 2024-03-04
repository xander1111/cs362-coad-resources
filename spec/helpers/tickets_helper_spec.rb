require 'rails_helper'

RSpec.describe TicketsHelper, type: :helper do

  describe "format_phone_number" do

    it "formats a phone number using a US country code" do
      expect(helper.format_phone_number("555 555 1234")).to eq("+15555551234")
    end

  end

end
