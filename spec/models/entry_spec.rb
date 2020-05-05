require 'rails_helper'

RSpec.describe Entry, type: :model do
  it 'factory bot' do
    entry = create(:entry)
    expect(entry).not_to be_nil
  end
end