require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  before do
    create(:user, name: 'Alice', email: 'alice@example.com')
  end

  it 'ログインしてログアウトする' do
    visit '/'
    click_link 'ログイン'
    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_css('h1', text: 'Alice さんの記事')
    click_link 'ログアウト'
    expect(page).to have_text('ログアウトしました')
  end
end