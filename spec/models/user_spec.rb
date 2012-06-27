require 'spec_helper'

describe User do

  it "creation can be simulated with FactoryGirl" do
    u = FactoryGirl.create(:user)
  end

  it "is not an admin when first created" do
    u = FactoryGirl.create(:user)
    u.is_admin?.should be_false
  end

  it "becomes an admin when User.admin= assignment is performed" do
    u = FactoryGirl.create(:user)
    u.admin = true
    u.is_admin?.should be_true
  end

  it "has a FactoryGirl admin alias defined in factories.rb" do
    a = FactoryGirl.create(:admin)
  end

  it "creates an admin using only the specified factory" do
    a = FactoryGirl.create(:admin)
    a.is_admin?.should be_true
  end

end
