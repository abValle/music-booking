class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.integer :rating_musician
      t.text :review_musician
      t.text :review_company
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
