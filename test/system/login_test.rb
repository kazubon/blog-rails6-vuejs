require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  setup do
    create(:user, name: 'Alice', email: 'alice@example.com')
  end

  test 'ログインしてログアウトする' do
    visit '/'
    click_link 'ログイン'
    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_css('h1', text: 'Alice さんの記事')
    click_link 'ログアウト'
    assert_text('ログアウトしました')
  end
end