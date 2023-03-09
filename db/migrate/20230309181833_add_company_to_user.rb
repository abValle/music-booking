class AddCompanyToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :company, :boolean
  end
end
