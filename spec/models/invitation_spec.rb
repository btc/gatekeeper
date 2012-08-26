require 'spec_helper'

describe Invitation do
  it { should belong_to :guest }
  it { should belong_to :event }
  it { should belong_to :guest_list }

  it { should validate_presence_of :date }
  it { should validate_presence_of :guest_list }
  it { should validate_presence_of :guest }
  it { should validate_presence_of :redeemed }

  it { should have_db_column :date }
  it { should have_db_column :guest_id }
  it { should have_db_column :event_id }
  it { should have_db_column :guest_list_id }
  it { should have_db_column :plus }
  it { should have_db_column :redeemed }

  it { should allow_mass_assignment_of :event_id }
  it { should allow_mass_assignment_of :guest_id }
  it { should allow_mass_assignment_of :guest_list_id }
  it { should allow_mass_assignment_of :date }
  it { should allow_mass_assignment_of :redeemed }
  it { should allow_mass_assignment_of :plus }
end
