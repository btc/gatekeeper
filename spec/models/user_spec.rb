require 'spec_helper'

describe User do

  it "creation can be simulated with FactoryGirl" do
    u = FactoryGirl.create(:user)
  end

  it "is not an admin when first created"
  it "becomes an admin when User.admin= assignment is performed"
  it "has a FactoryGirl admin alias defined in factories.rb"
  it "creates an admin using only the specified factory"

  it 'should have a method that lets you append a new role' do
    u = FactoryGirl.create(:user)
    u.add_role!(:admin)
    u.has_role?(:admin).should eq(true)
  end

  it "shouldn't have a role if i didn't add it" do
    u = FactoryGirl.create(:user)
    u.has_role?(:admin).should eq(false)
  end

  it 'should have a door_attendant role' do
    u = FactoryGirl.create :user
    u.add_role! :door_attendant
    u.save

    u.has_role?(:door_attendant).should eq(true)
  end

  it { should belong_to(:guest) }
  it { should have_and_belong_to_many(:committees) }
end
