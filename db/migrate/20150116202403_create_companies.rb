class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :full_name
      t.string :domain
      t.string :url
      t.text :description
      t.integer :tel
      t.integer :user_id
      t.timestamps
    end
    add_index :companies, :user_id
  end
end
