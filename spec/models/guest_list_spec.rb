require 'spec_helper'

describe GuestList do
  it { should belong_to(:creator).class_name('User') }
  it { should belong_to(:owner).class_name('Guest') }
  it { should belong_to(:event) }
  it { should have_one(:reservation) }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:guests).through(:invitations) }

  it 'should have many notes' # TODO notes polymorphic association

  it { should validate_presence_of :date }
  it { should validate_presence_of :owner }
  it { should validate_presence_of :creator }
  it 'should validate uniqueness of owner for specific date'
  it { should_not validate_presence_of :event }

  it { should have_db_column :date }
  it { should have_db_column :creator_id }
  it { should have_db_column :owner_id }
  it { should have_db_column :event_id }
  it { should have_db_column :published }

  it { should allow_mass_assignment_of :date }
  it { should allow_mass_assignment_of :creator_id }
  it { should allow_mass_assignment_of :owner_id }
  it { should allow_mass_assignment_of :event_id }

  before :each do
    @guest_list = GuestList.new
    @guest_list.creator = FactoryGirl.create(:user)
    @guest_list.date = Date.today
    @guest_list.owner = FactoryGirl.create(:guest)
  end

  it 'should be not be valid if no owner is present' do
    @guest_list.owner = nil
    @guest_list.valid?.should eq(false)
  end

  it 'should be able to be assigned an owner' do
    @guest_list.owner = nil
    @guest = FactoryGirl.create(:guest)
    @guest_list.owner = @guest
    @guest_list.owner.should eq(@guest)
  end

  it 'should default to approved == false' do
    @guest_list = GuestList.new
    @guest_list.approved.should eq(false)
  end

  it 'should default to draft == true' do
    @guest_list = GuestList.new
    @guest_list.draft?.should eq(true)
  end

  it 'should not be pending if approved' do
    @guest_list.approve!
    @guest_list.pending?.should eq(false)
  end

  it 'should not be pending once approved' do
    @guest_list.approve!
    @guest_list.pending?.should eq(false)
  end

  it 'should not be approved once revoked' do
    @guest_list.approve!
    @guest_list.pending?.should eq(false)
    @guest_list.approved?.should eq(true)
    @guest_list.revoke!
    @guest_list.pending?.should eq(true)
    @guest_list.approved?.should eq(false)
  end
end
