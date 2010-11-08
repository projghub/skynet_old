class ReportsController < AuthenticateController
	before_filter :init_dates

	def index
		redirect_to :controller => "reports", :action => "by_campaigns"
	end

	def filter
		start_date = params[:reports_filter][:start_date]
		if !start_date.nil?
			if start_date.empty?
				start_date = nil
			elsif start_date =~ /\A[0-9]{4}-[0-9]{2}-[0-9]{2}\Z/ && t = (Time.parse(start_date) rescue false)
				start_date = Time.utc(t.year, t.month, t.day).to_i
			else
				return redirect_from_filter
			end
		end
		end_date = params[:reports_filter][:end_date]
		if !end_date.nil?
			if end_date.empty?
				end_date = nil
			elsif end_date =~ /\A[0-9]{4}-[0-9]{2}-[0-9]{2}\Z/ && t = (Time.parse(end_date) rescue false)
				end_date = Time.utc(t.year, t.month, t.day, 23, 59, 59).to_i
			else
				return redirect_from_filter
			end
		end
		if !start_date.nil?
			return redirect_from_filter if start_date > Time.now.getutc.to_i || (!end_date.nil? && start_date > end_date)
		end
		if !end_date.nil?
			t = Time.now.getutc
			return redirect_from_filter if end_date > Time.utc(t.year, t.month, t.day, 23, 59, 59).to_i
			if start_date.nil?
				t = Time.at(end_date).getutc
				start_date = Time.utc(t.year, t.month, t.day)
			end
		end
		session[:reports_start_date] = start_date
		session[:reports_end_date] = end_date
		redirect_from_filter
	end

	def by_campaigns
		@campaigns = Campaign\
			.select("campaigns.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks, sum(serving_stats.spent) spent")\
			.joins(:ad_groups => {:ads => :serving_stats})\
			.where(
				"ads.deleted_at is null and campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?",
				@auth_user.account_id,
				session[:reports_start_date],
				session[:reports_end_date]
			)\
			.group("campaigns.id")\
			.order("ads.enabled desc, sum(serving_stats.impressions) desc")\
			.all
	end

	def by_ad_groups
		@ad_groups = AdGroup\
			.select("ad_groups.*, campaigns.enabled as campaign_enabled, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks, sum(serving_stats.spent) spent")\
			.joins(:ads => :serving_stats, :campaign => {})\
			.where(
				"ads.deleted_at is null and campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?",
				@auth_user.account_id,
				session[:reports_start_date],
				session[:reports_end_date]
			)\
			.group("ad_groups.id")\
			.order("campaigns.enabled desc, sum(serving_stats.impressions) desc")\
			.all
	end

	def by_ads
		@ads = Ad\
			.select("ads.*, campaigns.enabled as campaign_enabled, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks, sum(serving_stats.spent) spent")\
			.joins(:serving_stats => {}, :ad_group => :campaign)\
			.where(
				"campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?",
				@auth_user.account_id,
				session[:reports_start_date],
				session[:reports_end_date]
			)\
			.group("ads.id")\
			.order("ads.enabled + campaigns.enabled desc, sum(serving_stats.impressions) desc")\
			.all
	end

	def by_publishers
		@publishers = Publisher\
			.select("publishers.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks, sum(serving_stats.spent) spent")\
			.joins(:serving_stats => {:ad => {:ad_group => :campaign}})\
			.where(
				"ads.deleted_at is null and campaigns.deleted_at is null and campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?",
				@auth_user.account_id,
				session[:reports_start_date],
				session[:reports_end_date]
			)\
			.group("publishers.id")\
			.order("publishers.enabled desc, sum(serving_stats.impressions) desc")\
			.all
	end

	def by_templates
		@templates = Template\
			.select("templates.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks, sum(serving_stats.spent) spent")\
			.joins(:serving_stats => {:ad => {:ad_group => :campaign}})\
			.where(
				"ads.deleted_at is null and campaigns.deleted_at is null and campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?",
				@auth_user.account_id,
				session[:reports_start_date],
				session[:reports_end_date]
			)\
			.group("templates.id")\
			.order("sum(serving_stats.impressions) desc")\
			.all
	end

	def by_ad_types
		@ad_types = AdType\
			.select("ad_types.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks, sum(serving_stats.spent) spent")\
			.joins(:templates => {:serving_stats => {:ad => {:ad_group => :campaign}}})\
			.where(
				"ads.deleted_at is null and campaigns.deleted_at is null and campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?",
				@auth_user.account_id,
				session[:reports_start_date],
				session[:reports_end_date]
			)\
			.group("ad_types.id")\
			.order("sum(serving_stats.impressions) desc")\
			.all
	end

	protected
	def init_dates
		if session[:reports_start_date].nil?
			t = Time.now
			session[:reports_start_date] = Time.utc(t.year, t.month, t.day).to_i
		end
		if session[:reports_end_date].nil?
			t = Time.now
			session[:reports_end_date] = Time.utc(t.year, t.month, t.day, 23, 59, 59).to_i
		end
	end

	def redirect_from_filter
		if !params[:redirect_action].nil? && %w{by_campaigns by_ad_groups by_ads by_publishers by_templates by_ad_types}.include?(params[:redirect_action])
			redirect_to :controller => "reports", :action => params[:redirect_action]
		else
			redirect_to :controller => "reports", :action => "index"
		end
	end
end
