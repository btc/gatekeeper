require 'spec_helper'

describe Invitation do
  it { should belong_to :guest }
  it { should belong_to :event }
  it { should belong_to :guest_list }

  it { should validate_presence_of :guest_list }
  it { should validate_presence_of :guest }
  it { should validate_presence_of :redeemed }

  # GuestList has a date. And since invitation must have GuestList,
  # it gets its date from Guestlist
  it { should_not have_db_column :date }
  it { should have_db_column :guest_id }
  it { should have_db_column :event_id }
  it { should have_db_column :guest_list_id }
  it { should have_db_column(:plus).of_type(:integer).
       with_options(default: 0) }
  it { should have_db_column(:redeemed).of_type(:boolean).
       with_options(default: false) }

  it { should allow_mass_assignment_of :event_id }
  it { should allow_mass_assignment_of :guest_id }
  it { should allow_mass_assignment_of :guest_list_id }
  it { should allow_mass_assignment_of :redeemed }
  it { should allow_mass_assignment_of :plus }

  it 'gets its date from guest_list'
end
