class ChangeCategoryStringInMusician < ActiveRecord::Migration[7.0]
  def change
    change_column :musicians, :category, :text
  end
end
