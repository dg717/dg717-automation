class AddSpecialPricingToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :special_pricing, :integer
  end
end
