class CreateProposals < ActiveRecord::Migration[7.0]
  def change
    create_table :proposals do |t|
      t.references :musician, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.boolean :winner

      t.timestamps
    end
  end
end
