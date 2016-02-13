class CreateLockerKeys < ActiveRecord::Migration
  def change
    create_table :locker_keys do |t|
      t.integer :user_id
      t.integer :key_number
      t.integer :locker_number
      t.integer :status

      t.timestamps
    end
    add_index :locker_keys, :user_id
  end
end
