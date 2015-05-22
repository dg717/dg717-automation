class AddDeskTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :desk_type, :integer, :default => 0
  end
end
