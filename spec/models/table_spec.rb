require 'spec_helper'

describe Table do
  it { should have_db_column(:name) }
  it { should have_db_column(:number) }
  it { should have_many(:reservations) }

  before :each do
    @table = Table.create(name: 'party', number: '004')
  end

  it 'is NOT free if it HAS a reservation with given date' do
    date = Date.today
    @table.reservations.create(date: date)
    @table.free_on(date).should eq(false)
  end

  it 'is free if it has no reservations with given date' do
    date = Date.today
    @table.reservations.destroy_all
    @table.free_on(date).should eq(true)
  end

  it 'returns true if date is string.new' do
    @table.free_on([]).should eq(true)
  end

  it 'returns true if date is string.new' do
    @table.free_on("").should eq(true)
  end

  it 'returns true if date is nil' do
    @table.free_on(nil).should eq(true)
  end
end
