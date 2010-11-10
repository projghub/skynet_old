class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def api_authenticate
		@user = User.authenticate(params[:username], params[:password])
		if @user.nil?
			raise Exception.new("Cannot authenticate.")
		end
  end
end
