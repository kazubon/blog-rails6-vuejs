require 'test_helper'
 
class EntryTest < ActiveSupport::TestCase
  test 'factory bot' do
    entry = create(:entry)
    assert entry
  end
end