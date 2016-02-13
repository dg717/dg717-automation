class AddTypeToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :company_type, :integer
    add_column :companies, :logo, :string
  end
end
