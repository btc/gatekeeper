require 'spec_helper'

describe Guest do
  before :each do
    @guest = Guest.create(first_name: 'brian', last_name: 'lara')
  end

  it 'should require first_name' do
    @guest.first_name = nil
    @guest.valid?.should eq(false)
  end

  it 'should require last_name' do
    @guest.last_name = nil
    @guest.valid?.should eq(false)
  end
end
