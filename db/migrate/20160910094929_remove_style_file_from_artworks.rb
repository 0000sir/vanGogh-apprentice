class RemoveStyleFileFromArtworks < ActiveRecord::Migration[5.0]
  def up
    remove_attachment :artworks, :style_file
  end
  
  def down
    add_attachment :artwors, :style_file
  end
end
