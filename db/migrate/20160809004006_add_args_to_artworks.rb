class AddArgsToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :ext_arg, :string
  end
end
