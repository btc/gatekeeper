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

  it 'should be invalid if gender is not present' do
    @guest.gender = nil
    @guest.valid?.should eq(false)
  end

  it 'should be invalid if gender is not male or female' do
    @guest.gender = 'something else'
    @guest.valid?.should eq(false)
  end

  it 'should be valid if gender is male' do
    @guest.gender = 'male'
    @guest.valid?.should eq(true)
  end

  it 'should be valid if gender is female' do
    @guest.gender = 'female'
    @guest.valid?.should eq(true)
  end

  it 'should return male and female genders for Guest.genders' do
    genders = ['female', 'male']
    Guest.genders.should eq(genders)
  end

  it { should have_many(:photos) }
  it { should have_and_belong_to_many(:events) }
  it { should have_and_belong_to_many(:guestlists) }
  it { should have_one(:user) }

end
