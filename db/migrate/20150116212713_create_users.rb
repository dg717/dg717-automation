class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.integer :yaroom_id
      t.integer :company_id
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :company_id
    add_index :users, :yaroom_id
  end
end
