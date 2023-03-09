class AddTitleEventToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :title_event, :string
  end
end
