require 'spec_helper'

describe Table do
  it { should have_db_column(:name) }
  it { should have_db_column(:number) }
  it { should have_many(:reservations) }
end
