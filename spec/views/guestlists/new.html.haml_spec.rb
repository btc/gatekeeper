require 'spec_helper'

describe "guestlists/new" do
  before(:each) do
    assign(:guestlist, stub_model(Guestlist).as_new_record)
  end

  it "renders new guestlist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guestlists_path, :method => "post" do
    end
  end
end
