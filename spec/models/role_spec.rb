require 'spec_helper'

describe Role do

  before do
    @u = FactoryGirl.create(:user)
  end

  it "creation can be simulated using FactoryGirl" do
    r = FactoryGirl.create(:role, :name => 'admin', :user => @u)
  end

  it 'should respond to a class function called roles' do
    Role.roles.class.should eq(Array)
  end

  it { should have_db_column(:name) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
end
