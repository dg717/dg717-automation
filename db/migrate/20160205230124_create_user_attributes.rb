class CreateUserAttributes < ActiveRecord::Migration
  def change
    create_table :user_attributes do |t|
      t.integer :user_id
      t.text :interest
      t.string :favorite_color
      t.string :title

      t.timestamps
    end
    add_index :user_attributes, :user_id
  end
end
