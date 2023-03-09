class AddDescriptionEventToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :description_event, :text
  end
end
