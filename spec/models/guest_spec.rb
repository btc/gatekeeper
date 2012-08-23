require 'spec_helper'

describe Guest do
  before :each do
    @guest = Guest.create(first_name: 'brian', last_name: 'lara', gender: 'male')
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

  it 'does not need a rating' do
    @guest.rating = nil
    @guest.valid?.should eq(true)
  end

  it 'can have a rating anywhere between 1 and 5 (inclusive) if rating defined' do
    (1..5).each do |n|
      @guest.rating = n
      @guest.valid?.should eq(true)
    end
  end

  it 'should be invalid if rating is defined and stricyly greater than 5' do
    (6..10).each do |n|
      @guest.rating = n
      @guest.valid?.should eq(false)
    end
  end

  it 'should be invalid if rating is defined and stricyly less than 1' do
    (-10..0).each do |n|
      @guest.rating = n
      @guest.valid?.should eq(false)
    end
  end

  it 'returns false for is_five_star? if @guest.rating != 5' do
    (1..4).each do |n|
      @guest.rating = n
      @guest.is_five_star?.should eq(false)
    end
  end

  it 'is_five_star if @guest.rating == 5' do
    @guest.rating = 5
    @guest.is_five_star?.should eq(true)
  end

  it 'last_photo returns nil if no photo present' do
    @guest.photos = []
    @guest.last_photo.should eq(nil)
  end

  it { should have_many(:photos) }
  it { should have_many(:notes) }
  it { should have_and_belong_to_many(:events) }
  it { should have_and_belong_to_many(:guestlists) }
  it { should have_one(:user) }
  it { should belong_to(:creator) }

  it { should accept_nested_attributes_for(:photos) }
  it { should accept_nested_attributes_for(:notes) }

  it { should allow_mass_assignment_of :notes_attributes }
  it 'should allow allow_mass_assignment_of photos_attributes'
end
