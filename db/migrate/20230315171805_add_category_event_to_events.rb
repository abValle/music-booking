class AddCategoryEventToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :category_event, :text
  end
end
