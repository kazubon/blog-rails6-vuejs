require 'rails_helper'

RSpec.describe '記事', type: :system do
  include LoginHelper

  let(:user) { create(:user, name: 'Alice', email: 'alice@example.com') }

  before do
    login(user)
  end

  it '記事の作成' do
    click_link '新規作成'
    fill_in 'タイトル', with: 'ほげほげ'
    fill_in '本文', with: "ほげほげ\nふがふが"
    fill_in 'entry-tag0', with: 'ほげほげ'
    fill_in 'entry-tag1', with: 'ふがふが'
    click_button '作成'
    expect(page).to have_text('記事を作成しました。')
  end
end