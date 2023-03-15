class RemoveEndDateFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :end_date, :date
  end
end
