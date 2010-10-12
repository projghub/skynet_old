class AdsController < AuthenticateController
	# GET /ads
	# GET /ads.xml
	def index
		@ads = Ad.includes({:ad_group => :campaign}, :ad_type).where("campaigns.account_id = ?", @auth_user.account_id).all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @ads }
		end
	end

	# GET /ads/1
	# GET /ads/1.xml
	def show
		@ad = Ad.includes({:ad_group => :campaign}, :ad_type).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @ad }
		end
	end

	# GET /ads/new
	# GET /ads/new.xml
	def new
		@ad = Ad.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @ad }
		end
	end

	# GET /ads/1/edit
	def edit
		@ad = Ad.includes({:ad_group => :campaign}, :ad_type).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])
	end

	# POST /ads
	# POST /ads.xml
	def create
		@ad = Ad.new(params[:ad])
		@ad.user_account_id = @auth_user.account_id

		respond_to do |format|
			if @ad.save
				upload_media
				format.html { redirect_to(@ad, :notice => 'Ad was successfully created.') }
				format.xml  { render :xml => @ad, :status => :created, :location => @ad }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /ads/1
	# PUT /ads/1.xml
	def update
		@ad = Ad.includes({:ad_group => :campaign}, :ad_type).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])
		@ad.user_account_id = @auth_user.account_id

		respond_to do |format|
			if @ad.update_attributes(params[:ad])
				upload_media
				format.html { redirect_to(@ad, :notice => 'Ad was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /ads/1
	# DELETE /ads/1.xml
	#def destroy
	#  @ad = Ad.includes({:ad_group => :campaign}, :ad_type).where("campaigns.account_id = ?", @auth_user.account_id).find(params[:id])
	#  @ad.destroy

	#  respond_to do |format|
	#	  format.html { redirect_to(ads_url) }
	#	  format.xml  { head :ok }
	#  end
	#end

	protected
	def upload_media
		spawn do
			logger.info "Starting file upload to Rackspace."
			creds = YAML.load_file("#{Rails.root}/config/rackspace.yml")[Rails.env]
			conn = CloudFiles::Connection.new(creds["username"], creds["api_key"])
			container_name = "#{creds["container"]}_#{@ad.id}"
			if conn.container_exists?(container_name)
				container = conn.container(container_name) 
			else
				container = conn.create_container(container_name)
				container.make_public
			end
			object = container.create_object(@ad.media.original_filename)
			object.load_from_filename(@ad.media.path)
			@ad.media_url = object.public_url
			@ad.save
			logger.info "File finished uploading to Rackspace and saved URL."
		end unless params[:ad][:media].nil?
	end
end
