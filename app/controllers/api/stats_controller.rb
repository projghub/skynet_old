class Api::StatsController < ApplicationController
	protect_from_forgery :except => :index
	before_filter :api_authenticate
	layout false

	def index
		@passed_groups = params[:groups].nil? ? [] : params[:groups].split(",")
		q = ServingStat.select("sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks, sum(serving_stats.spent) spent, serving_stats.time_served").joins(:ad => {:ad_group => :campaign}).where("campaigns.account_id = ?", @user.account_id).group("serving_stats.time_served div 86400").order("time_served")
		q = q.select("campaigns.id campaign_id, serving_stats.ad_id").group("campaigns.id").where("ads.deleted_at is null and campaigns.deleted_at is null").order("campaigns.id") if @passed_groups.include?("campaign")
		q = q.select("serving_stats.ad_id").group("serving_stats.ad_id").where("ads.deleted_at is null").order("serving_stats.ad_id") if @passed_groups.include?("ad")
		q = q.select("serving_stats.template_id").joins(:template).group("serving_stats.template_id").order("serving_stats.template_id") if @passed_groups.include?("template")
		q = q.select("serving_stats.position").group("serving_stats.position").order("serving_stats.position") if @passed_groups.include?("position")
		q = q.select("serving_stats.publisher_id").joins(:publisher).group("serving_stats.publisher_id").where("publishers.deleted_at is null").order("serving_stats.publisher_id") if @passed_groups.include?("publisher")
		@stats = q.all
		respond_to do |format|
			format.html # index.html.erb
			format.csv  # index.csv.erb
			format.json do
				@stats.each { |stat| stat.ad_id = nil } if @passed_groups.include?("campaign") && !@passed_groups.include?("ad")
				render :json => @stats.to_json
			end
			format.xml  { render :xml => @stats }
		end
	end
end
