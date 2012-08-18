require 'spec_helper'

describe "guestlists/edit" do
  before(:each) do
    @guestlist = assign(:guestlist, stub_model(Guestlist))
  end

  it "renders the edit guestlist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guestlists_path(@guestlist), :method => "post" do
    end
  end
end
