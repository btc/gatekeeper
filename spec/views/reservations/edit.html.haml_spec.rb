require 'spec_helper'

describe "reservations/edit", auth: true do
  before(:each) do
    @reservation = assign(:reservation, stub_model(Reservation))
  end

  it "renders the edit reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservations_path(@reservation), :method => "post" do
    end
  end
end
