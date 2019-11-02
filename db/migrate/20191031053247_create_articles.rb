class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false
      t.string :title
      t.text :body
      t.boolean :draft, null: false, default: false
      t.datetime :published_at, null: false
      t.timestamps
    end
  end
end
