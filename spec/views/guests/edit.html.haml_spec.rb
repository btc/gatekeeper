require 'spec_helper'

describe "guests/edit" do
  before(:each) do
    @guest = assign(:guest, stub_model(Guest,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :phone_number => "MyString"
    ))
  end

  it "renders the edit guest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guests_path(@guest), :method => "post" do
      assert_select "input#guest_first_name", :name => "guest[first_name]"
      assert_select "input#guest_last_name", :name => "guest[last_name]"
      assert_select "input#guest_email", :name => "guest[email]"
      assert_select "input#guest_phone_number", :name => "guest[phone_number]"
    end
  end
end
