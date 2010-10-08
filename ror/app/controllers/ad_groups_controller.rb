class AdGroupsController < AuthenticateController
	# GET /ad_groups
	# GET /ad_groups.xml
	def index
		@ad_groups = AdGroup.includes(:campaign).where("campaigns.account_id = ?", @auth_user.account_id).all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @ad_groups }
		end
	end

	# GET /ad_groups/1
	# GET /ad_groups/1.xml
	def show
		@ad_group = AdGroup.includes(:campaign).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @ad_group }
		end
	end

	# GET /ad_groups/new
	# GET /ad_groups/new.xml
	def new
		@ad_group = AdGroup.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @ad_group }
		end
	end

	# GET /ad_groups/1/edit
	def edit
		@ad_group = AdGroup.includes(:campaign).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])
	end

	# POST /ad_groups
	# POST /ad_groups.xml
	def create
		@ad_group = AdGroup.new(params[:ad_group])
		@ad_group.user_account_id = @auth_user.account_id

		respond_to do |format|
			if @ad_group.save
				format.html { redirect_to(@ad_group, :notice => 'Ad group was successfully created.') }
				format.xml  { render :xml => @ad_group, :status => :created, :location => @ad_group }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @ad_group.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /ad_groups/1
	# PUT /ad_groups/1.xml
	def update
		@ad_group = AdGroup.includes(:campaign).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])
		@ad_group.user_account_id = @auth_user.account_id

		respond_to do |format|
			if @ad_group.update_attributes(params[:ad_group])
				format.html { redirect_to(@ad_group, :notice => 'Ad group was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @ad_group.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /ad_groups/1
	# DELETE /ad_groups/1.xml
	#def destroy
	#	@ad_group = AdGroup.includes(:campaign).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])
	#	@ad_group.destroy

	#	respond_to do |format|
	#		format.html { redirect_to(ad_groups_url) }
	#		format.xml  { head :ok }
	#	end
	#end
end
