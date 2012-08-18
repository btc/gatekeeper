require 'spec_helper'

describe Event do
  it { should have_and_belong_to_many(:committees) }
  it { should have_and_belong_to_many(:guests) }
end
