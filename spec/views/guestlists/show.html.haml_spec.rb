require 'spec_helper'

describe "guestlists/show" do
  before(:each) do
    @guestlist = assign(:guestlist, stub_model(Guestlist))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
