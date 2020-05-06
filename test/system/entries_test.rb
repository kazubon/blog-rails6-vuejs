require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  include LoginHelper

  setup do
    user = create(:user, name: 'Alice', email: 'alice@example.com')
    create(:entry, title: '他の人の記事')
    login(user)
  end

  test '記事の作成' do
    click_link '新規作成'
    fill_in 'タイトル', with: 'ほげほげ'
    fill_in '本文', with: "ほげほげ\nふがふが"
    fill_in 'entry-tag0', with: 'ほげほげ'
    fill_in 'entry-tag1', with: 'ふがふが'
    click_button '作成'
    assert_text('記事を作成しました。')
  end

  test 'スターを付ける' do
    visit '/'
    click_link '他の人の記事'
    sleep 1
    click_link '👍'
    assert_text('⭐️ 1')
  end
end