require 'rails_helper'

RSpec.describe '記事', type: :system do
  include LoginHelper

  let(:user) { create(:user, name: 'Alice', email: 'alice@example.com') }

  before do
    create(:entry, title: '他の人の記事')
    create(:entry, title: '自分の記事', user: user)
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

  it '記事の編集' do
    click_link '自分の記事'
    click_link '編集'
    fill_in 'タイトル', with: 'ほげほげ'
    click_button '更新'
    expect(page).to have_text('記事を更新しました。')
  end

  it '記事の削除' do
    click_link '自分の記事'
    click_link '編集'
    accept_confirm do
      click_button '削除'
    end
    expect(page).to have_text('記事を削除しました。')
  end

  it 'スターを付ける' do
    visit '/'
    click_link '他の人の記事'
    click_link '👍'
    expect(page).to have_text('⭐️ 1')
  end
end