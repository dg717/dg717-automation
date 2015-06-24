class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.datetime :last_sent
      t.integer :last_total, default: 0
      t.integer :company_id
      t.timestamps
    end
  end
end
