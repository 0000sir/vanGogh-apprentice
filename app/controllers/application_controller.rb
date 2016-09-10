class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'bootstrap'
  
  def api_auth
		authenticate_or_request_with_http_basic do |username, password|
			return username=='0000' && password=='123456'
		end
	end
	
	def json_request?
    request.format.symbol == :json
  end
end
