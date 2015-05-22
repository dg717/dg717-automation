class AddChargeableToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :chargeable, :boolean, :default => true
  end
end
