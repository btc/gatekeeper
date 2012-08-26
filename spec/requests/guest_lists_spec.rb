require 'spec_helper'

describe "GuestLists", auth: true do
  describe "GET /guest_lists" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get guest_lists_path
      response.status.should be(200)
    end
  end
end
