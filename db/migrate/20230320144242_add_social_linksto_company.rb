class AddSocialLinkstoCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :instagram_url, :string
    add_column :companies, :facebook_url, :string
    add_column :companies, :soundcloud_url, :string
    add_column :companies, :youtube_url, :string
    add_column :companies, :spotify_url, :string
  end
end
