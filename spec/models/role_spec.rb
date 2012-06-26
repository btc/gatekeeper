require 'spec_helper'

describe Role do

  before do
    @u = FactoryGirl.create(:user)
  end

  it "creation can be simulated using FactoryGirl" do
    r = FactoryGirl.create(:role, :name => 'admin', :user => @u)
  end

end
