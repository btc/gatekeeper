require 'spec_helper'

describe "reservations/show", auth: true do
  before(:each) do
    @reservation = assign(:reservation, stub_model(Reservation))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
