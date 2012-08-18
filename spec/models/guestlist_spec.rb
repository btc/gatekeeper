require 'spec_helper'

describe Guestlist do
  it { should have_and_belong_to_many(:guests) }
  it { should belong_to(:user) }
end
