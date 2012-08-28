require 'spec_helper'

describe GuestList do
  it { should belong_to(:creator).class_name('User') }
  it { should belong_to(:owner).class_name('Guest') }
  it { should belong_to(:event) }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:guests).through(:invitations) }

  it 'should have many notes' # TODO notes polymorphic association

  it { should validate_presence_of :date }
  it { should validate_presence_of :owner }
  it { should validate_presence_of :creator }
  it { should_not validate_presence_of :event }

  it { should have_db_column :date }
  it { should have_db_column :creator_id }
  it { should have_db_column :owner_id }
  it { should have_db_column :event_id }

  it { should allow_mass_assignment_of :date }
  it { should allow_mass_assignment_of :creator_id }
  it { should allow_mass_assignment_of :owner_id }
  it { should allow_mass_assignment_of :event_id }
end
