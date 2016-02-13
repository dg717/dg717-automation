class CreateExternalServices < ActiveRecord::Migration
  def change
    create_table :external_services do |t|
      t.integer :user_id
      t.integer :envoy_status
      t.integer :yaroom_status
      t.integer :google_status
      t.integer :meraki_status

      t.timestamps
    end
    add_index :external_services, :user_id
  end
end
