class CreateArtworks < ActiveRecord::Migration[5.0]
  def change
    create_table :artworks do |t|
      t.attachment :source_file
      t.attachment :style_file
      t.attachment :output_file
      t.integer :status

      t.timestamps
    end
  end
end
