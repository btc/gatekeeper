require 'spec_helper'

describe Committee do
  it { should have_and_belong_to_many(:events) }
  it { should have_and_belong_to_many(:users) }
end
