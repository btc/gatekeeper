require 'spec_helper'

describe "committees/edit" do
  before(:each) do
    @committee = assign(:committee, stub_model(Committee))
  end

  it "renders the edit committee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => committees_path(@committee), :method => "post" do
    end
  end
end
