class AddDeleteAtToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :deleted_at, :datetime
  end
end
