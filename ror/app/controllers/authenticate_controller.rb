class AuthenticateController < ApplicationController
	before_filter :session_init, :except => [:login, :logout]

	def login
		if request.post?
			user = User.joins(:account).where("users.username = ? AND users.enabled = ? AND accounts.enabled = ?", params[:login][:username], true, true).first rescue nil
			logger.debug user.inspect
			if user.nil? || !user.password_matches?(params[:login][:password])
				flash[:error] = "We could not authenticate you based on the provided username and password."
			else
				session[:user_id] = user.id
				flash[:notice] = "You have successfully logged in."
				redirect_to users_path(user.id)
			end
		end
	end

	def logout
		session[:user_id] = nil
		flash[:notice] = "You have successfully logged out."
		redirect_to "/index.html" # TODO: Fix logout redirect url.
	end

	private
	def session_init
		unless session[:user_id].nil?
			@auth_user = User.find session[:user_id]
			unless @auth_user.nil?
				return true
			end
		end
		flash[:error] = "You will need to login before completing that action."
		redirect_to :controller => "authenticate", :action => "login"
	end
end

