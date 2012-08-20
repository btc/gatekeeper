require 'spec_helper'

describe Note do

  before :each do
    @note = Note.new
    @note.body = ''
  end

  it 'should reject empty body' do
    @note.body = ''
    @note.save.should eq(false)
  end

  it 'should accept a body that is 140 chars' do
    140.times { @note.body << 'a' }
    @note.save.should eq(true)
  end

  it 'should reject a body that is 141 chars' do
    141.times { @note.body << 'a' }
    @note.save.should eq(false)
  end

  it 'should strip the body text' do
    text = ' hello '
    @note.body = text
    @note.save
    @note.body.should eq(text.strip)
  end

  it { should validate_presence_of(:body) }
  it { should belong_to(:guest) }

  it { should have_db_column(:body) }
end
