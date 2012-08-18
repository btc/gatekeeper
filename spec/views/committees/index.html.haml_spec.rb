require 'spec_helper'

describe "committees/index" do
  before(:each) do
    assign(:committees, [
      stub_model(Committee),
      stub_model(Committee)
    ])
  end

  it "renders a list of committees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
