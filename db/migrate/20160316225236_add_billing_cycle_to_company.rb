class AddBillingCycleToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :billing_cycle, :integer
  end
end
