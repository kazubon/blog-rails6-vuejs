class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true
      t.string :name, null: false
      t.string :hashed_password, null: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
