class ChangeCompanyToCompanyBooleanInUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :company, :boolean_company
  end
end
