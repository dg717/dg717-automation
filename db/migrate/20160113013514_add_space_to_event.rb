class AddSpaceToEvent < ActiveRecord::Migration
  def change
    add_column :events, :space, :integer
  end
end
