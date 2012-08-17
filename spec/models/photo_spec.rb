require 'spec_helper'

describe Photo do
  it { should belong_to(:guest) }

  it 'generates a file name given an extension' do
    Photo.generate_file_name(extension: 'jpg').empty?.should eq(false)
  end

  it 'generates unique file names'
end
