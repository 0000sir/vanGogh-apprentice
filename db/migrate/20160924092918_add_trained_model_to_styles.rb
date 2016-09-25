class AddTrainedModelToStyles < ActiveRecord::Migration[5.0]
  def change
    add_attachment :styles, :trained_model
    add_column :styles, :trained_model_fingerprint, :string
  end
end
