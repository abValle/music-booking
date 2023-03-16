class CreatePushes < ActiveRecord::Migration[7.0]
  def change
    create_table :pushes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposal, null: false, foreign_key: true
      t.string :subject

      t.timestamps
    end
  end
end
