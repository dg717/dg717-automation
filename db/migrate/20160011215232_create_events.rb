class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :event_type
      t.text :description
      t.text :subtext
      t.string :image

      t.timestamps
    end
  end
end
