class AddSocialtoMusician < ActiveRecord::Migration[7.0]
  def change
    add_column :musicians, :facebook_url, :string
    add_column :musicians, :spotify_url, :string
    add_column :musicians, :youtube_url, :string
    add_column :musicians, :soundcloud_url, :string
  end
end
