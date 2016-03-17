class AddChargeableToUser < ActiveRecord::Migration
  def change
    add_column :users, :chargeable, :boolean, :default => true
  end
end
