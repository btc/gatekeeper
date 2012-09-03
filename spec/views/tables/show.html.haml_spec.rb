require 'spec_helper'

describe "tables/show" do
  before(:each) do
    @table = assign(:table, stub_model(Table,
      :name => "Name",
      :number => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
