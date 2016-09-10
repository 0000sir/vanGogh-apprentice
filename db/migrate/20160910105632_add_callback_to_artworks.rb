class AddCallbackToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :source_file_fingerprint, :string
    add_column :artworks, :callback, :string
  end
end
