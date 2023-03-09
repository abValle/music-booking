class RemoveRatingMusicianFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :rating_musician, :integer
  end
end
