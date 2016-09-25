class Artwork < ApplicationRecord
	has_attached_file :source_file, styles: { medium: "300x300>", thumb: "100x100>", large: "600x600>" }, default_url: "/images/:style/missing.jpg"
	has_attached_file :output_file, styles: { medium: "300x300>", thumb: "100x100>", large: "1024x1024>" }, default_url: "/images/:style/missing.jpg"
	belongs_to :style
	
	validates_attachment_content_type :source_file, content_type: /\Aimage/
	validates_attachment_content_type :output_file, content_type: /\Aimage/
	
	STATUS = %w{等待中 转换中 完成 失败}
	
	before_create :set_status
	after_create :convert
	
	def set_status
		self.status = 0
	end
	
	def call_it_back!
	  #p self.callback
          begin
	  RestClient.post(self.callback, 
	    "source"=>self.source_file_fingerprint, 
	    "output"=>File.new(self.output_file.path))
          rescue
            logger.info "error in callback"
          end
	end
	
	def clone_from_exist
	  exsiting = Artwork.where(:source_file_fingerprint=>self.source_file_fingerprint,
               :style_id=>self.style_id, :status=>2).first
    unless exsiting.nil?
      self.output_file = File.new(exsiting.output_file.path)
      self.save
      return true
    end
    return false
	end
	
	
	#:private
		def convert
		  unless self.clone_from_exist
        output = "/tmp/out_#{self.id}.jpg"
        self.status = 1
        self.save
        cmd = "#{Rails.root}/bin/convert.sh #{self.style.trained_model.path} #{self.source_file.path(:large)} #{self.ext_arg} #{output}"
        result = system(cmd)
        if result
          self.status = 2
          self.output_file = File.open output
          self.save
          self.call_it_back!
        else
          self.status = 3
        end
        self.save
      else
        self.call_it_back!
			end
		end
		handle_asynchronously :convert, :queue=>"paint"
		
end
