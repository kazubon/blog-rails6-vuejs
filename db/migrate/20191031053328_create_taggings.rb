class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.references :tag, null: false
      t.references :article, null: false
    end
  end
end
