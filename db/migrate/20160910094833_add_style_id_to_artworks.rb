class AddStyleIdToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :style_id, :integer
  end
end
