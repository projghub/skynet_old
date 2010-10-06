class AuthenticateController < ApplicationController
	before_filter :session_init, :except => [:login, :logout]

	def login
		redirect_to :controller => "default", :action => "index" if !session[:user_id].nil?
		if request.post?
			user = User.authenticate(params[:login][:username], params[:login][:password])
			if user.nil?
				flash[:error] = "We could not authenticate you based on the provided username and password."
			else
				session[:user_id] = user.id
				flash[:notice] = "You have successfully logged in."
				redirect_to :controller => "default", :action => "index"
			end
		end
	end

	def logout
		session[:user_id] = nil
		flash[:notice] = "You have successfully logged out."
		redirect_to :controller => "authenticate", :action => "login"
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

