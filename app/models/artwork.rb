class Artwork < ApplicationRecord
	has_attached_file :source_file, styles: { medium: "300x300>", thumb: "100x100>", large: "600x600>" }, default_url: "/images/:style/missing.jpg"
	has_attached_file :style_file, styles: { medium: "300x300>", thumb: "100x100>", large: "600x600>" }, default_url: "/images/:style/missing.jpg"
	has_attached_file :output_file, styles: { medium: "300x300>", thumb: "100x100>", large: "1024x1024>" }, default_url: "/images/:style/missing.jpg"
	
	validates_attachment_content_type :source_file, content_type: /\Aimage/
	validates_attachment_content_type :style_file, content_type: /\Aimage/
	validates_attachment_content_type :output_file, content_type: /\Aimage/
	
	STATUS = %w{等待中 转换中 完成 失败}
	
	before_create :set_status
	after_create :convert
	
	def set_status
		self.status = 0
	end
	
	
	:private
		def convert
			output = "/tmp/out_#{self.id}.jpg"
			self.status = 1
			self.save
			cmd = "#{Rails.root}/bin/convert.sh #{self.style_file.path((:large))} #{self.source_file.path(:large)} #{self.ext_arg} #{output}"
			result = system(cmd)
			if result
				self.status = 2
				self.output_file = File.open output
				self.save
			else
				self.status = 3
			end
			self.save
		end
		handle_asynchronously :convert, :queue=>"paint"
		
end
