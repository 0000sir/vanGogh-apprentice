class Style < ApplicationRecord
  has_many :artworks
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", large: "1024x1024>" }, default_url: "/images/:style/missing.jpg"
  has_attached_file :trained_model
  validates_attachment_content_type :image, content_type: /\Aimage/
  do_not_validate_attachment_file_type :trained_model
  
  Paperclip.options[:content_type_mappings] = {
		:t7 => "application/octet-stream"
	}
  
  def self.fetch(fingerprint, source=nil)
    style = Style.find_by_trained_model_fingerprint fingerprint
    if style.nil? and !source.nil?
      #style = Style.create :image=>source
      style_json = JSON.parse(RestClient.get(source).body)
      p style_json
      url = URI.parse(source)
      style = Style.create :image=>"#{url.scheme}://#{url.host}:#{url.port}#{style_json['image']}", :trained_model=>"#{url.scheme}://#{url.host}:#{url.port}#{style_json['trained_model']}"
    end
    return style
  end
end
