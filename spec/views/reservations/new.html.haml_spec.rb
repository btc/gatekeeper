require 'spec_helper'

describe "reservations/new", auth: true do
  before(:each) do
    assign(:reservation, stub_model(Reservation).as_new_record)
  end

  it "renders new reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservations_path, :method => "post" do
    end
  end
end
