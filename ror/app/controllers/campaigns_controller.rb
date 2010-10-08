class CampaignsController < AuthenticateController
	# GET /campaigns
	# GET /campaigns.xml
	def index
		@campaigns = Campaign.where(:account_id => @auth_user.account_id).all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @campaigns }
		end
	end

	# GET /campaigns/1
	# GET /campaigns/1.xml
	def show
		@campaign = Campaign.where(:account_id => @auth_user.account_id).find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @campaign }
		end
	end

	# GET /campaigns/new
	# GET /campaigns/new.xml
	def new
		@campaign = Campaign.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @campaign }
		end
	end

	# GET /campaigns/1/edit
	def edit
		@campaign = Campaign.where(:account_id => @auth_user.account_id).find(params[:id])
	end

	# POST /campaigns
	# POST /campaigns.xml
	def create
		@campaign = Campaign.new(params[:campaign])
		@campaign.account_id = @auth_user.account_id

		respond_to do |format|
			if @campaign.save
				format.html { redirect_to(@campaign, :notice => 'Campaign was successfully created.') }
				format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /campaigns/1
	# PUT /campaigns/1.xml
	def update
		@campaign = Campaign.where(:account_id => @auth_user.account_id).find(params[:id])

		respond_to do |format|
			if @campaign.update_attributes(params[:campaign])
				format.html { redirect_to(@campaign, :notice => 'Campaign was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /campaigns/1
	# DELETE /campaigns/1.xml
	#def destroy
	#	@campaign = Campaign.where(:account_id => @auth_user.account_id).find(params[:id])
	#	@campaign.destroy

	#	respond_to do |format|
	#		format.html { redirect_to(campaigns_url) }
	#		format.xml  { head :ok }
	#	end
	#end
end
