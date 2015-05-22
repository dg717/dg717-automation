class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :user_id
      t.integer :room_id
      t.integer :modified_by
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.datetime :cancelled_at
      t.datetime :yaroom_updated_at
      t.integer :yaroom_id
      t.timestamps
    end
    add_index :meetings, :user_id
    add_index :meetings, :room_id
    add_index :meetings, :yaroom_id
  end
end
