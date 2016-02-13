class CreateCardKeys < ActiveRecord::Migration
  def change
    create_table :card_keys do |t|
      t.integer :user_id
      t.string :key_number
      t.integer :status
      t.timestamps
    end
    add_index :card_keys, :user_id
  end
end
