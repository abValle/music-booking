class CreateMusicians < ActiveRecord::Migration[7.0]
  def change
    create_table :musicians do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :address
      t.string :category
      t.date :birth_date
      t.text :description
      t.string :phone
      t.integer :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
