class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :title
      t.string :address
      t.string :phone
      t.text :category
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
