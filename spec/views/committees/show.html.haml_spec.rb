require 'spec_helper'

describe "committees/show" do
  before(:each) do
    @committee = assign(:committee, stub_model(Committee))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
