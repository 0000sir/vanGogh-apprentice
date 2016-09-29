class StylesController < ApplicationController
	skip_before_action :verify_authenticity_token, :if => Proc.new{|c| c.request.format=='application/json'}
  def rsync
  	@style = Style.fetch params[:fingerprint], params[:source]
  	logger.info "Style ping"
  	render json: {'message'=>'ok'}, status: :ok 
  end
end
