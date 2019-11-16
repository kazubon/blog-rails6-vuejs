class CreateStars < ActiveRecord::Migration[6.0]
  def change
    create_table :stars do |t|
      t.references :entry, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
