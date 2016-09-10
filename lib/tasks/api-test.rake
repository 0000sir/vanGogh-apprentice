def api_test
  require 'rest_client'
  response = RestClient.post("http://0000:123456@127.0.0.1:3000/artworks.json", 
          "artwork[source_file]"=>File.new("#{Rails.root}/tmp/source.jpg"),
          "artwork[source_file_fingerprint]"=>"1235c8c1b2cda0a0f130c71eccc9c764",
          "artwork[style][fingerprint]"=>"9ead0c90b8a658c5fa6493ec6aa9b3ca",
          "artwork[style][source]"=>"http://127.0.0.1:3000/images/style2.jpg", 
          "artwork[callback]"=>"http://www.baidu.com/")
  p JSON.parse(response.body)
end

namespace :test do
  task :artwork_api=>:environment do
    api_test
  end
end