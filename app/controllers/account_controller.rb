class AccountController < AuthenticateController
	def edit
		@account = @auth_user.account
	end

	def update
		@account = @auth_user.account

		respond_to do |format|
			if @account.update_attributes(params[:account])
				format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
			end
		end
	end
end
