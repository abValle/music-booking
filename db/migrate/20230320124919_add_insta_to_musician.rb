class AddInstaToMusician < ActiveRecord::Migration[7.0]
  def change
    add_column :musicians, :instagram_url, :text
  end
end
