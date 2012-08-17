require 'spec_helper'

describe "guests/show" do
  before(:each) do
    @guest = assign(:guest, stub_model(Guest,
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email",
      :phone_number => "Phone Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
    rendered.should match(/Phone Number/)
  end
end
