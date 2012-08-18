require 'spec_helper'

describe "guestlists/index" do
  before(:each) do
    assign(:guestlists, [
      stub_model(Guestlist),
      stub_model(Guestlist)
    ])
  end

  it "renders a list of guestlists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
