class Style < ApplicationRecord
  has_many :artworks
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", large: "1024x1024>" }, default_url: "/images/:style/missing.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage/
  
  def self.fetch(fingerprint, source=nil)
    style = Style.find_by_image_fingerprint fingerprint
    if style.nil? and !source.nil?
      style = Style.create :image=>source
    end
    return style
  end
end
