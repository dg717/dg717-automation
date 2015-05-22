class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.float :cost
      t.integer :capacity
      t.integer :floor
      t.timestamps
    end
  end
end
