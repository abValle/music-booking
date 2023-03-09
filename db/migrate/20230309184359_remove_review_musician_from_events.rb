class RemoveReviewMusicianFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :review_musician, :text
  end
end
