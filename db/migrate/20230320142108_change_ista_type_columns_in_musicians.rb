class ChangeIstaTypeColumnsInMusicians < ActiveRecord::Migration[7.0]
  def change
    change_column(:musicians, :instagram_url, :string)
  end
end
