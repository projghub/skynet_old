class ReportsController < AuthenticateController
	before_filter :init_dates

	def index
		redirect_to :controller => "reports", :action => "by_campaigns"
	end

	def by_campaigns
		@campaigns = Ad.find_by_sql(["select campaigns.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks
			from campaigns
			left join ad_groups on campaigns.id = ad_groups.campaign_id
			left join ads on ad_groups.id = ads.ad_group_id
			left join serving_stats on ads.id = serving_stats.ad_id
			where campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?
			group by campaigns.id
			order by ads.enabled desc, sum(serving_stats.impressions) desc", @auth_user.account_id, session[:reports_start_date], session[:reports_end_date]])
	end

	def by_ad_groups
		@ad_groups = Ad.find_by_sql(["select ad_groups.*, campaigns.enabled as campaign_enabled, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks
			from ad_groups
			left join ads on ad_groups.id = ads.ad_group_id
			left join serving_stats on ads.id = serving_stats.ad_id
			left join campaigns on ad_groups.campaign_id = campaigns.id
			where campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?
			group by ad_groups.id
			order by campaigns.enabled desc, sum(serving_stats.impressions) desc", @auth_user.account_id, session[:reports_start_date], session[:reports_end_date]])
	end

	def by_ads
		@ads = Ad.find_by_sql(["select ads.*, campaigns.enabled as campaign_enabled, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks
			from ads
			left join serving_stats on ads.id = serving_stats.ad_id
			left join ad_groups on ads.ad_group_id = ad_groups.id
			left join campaigns on ad_groups.campaign_id = campaigns.id
			where campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?
			group by ads.id
			order by ads.enabled + campaigns.enabled desc, sum(serving_stats.impressions) desc", @auth_user.account_id, session[:reports_start_date], session[:reports_end_date]])
	end

	def by_publishers
		@publishers = Ad.find_by_sql(["select publishers.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks
			from publishers
			left join serving_stats on publishers.id = serving_stats.publisher_id
			left join ads on serving_stats.ad_id = ads.id
			left join ad_groups on ads.ad_group_id = ad_groups.id
			left join campaigns on ad_groups.campaign_id = campaigns.id
			where campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?
			group by publishers.id
			order by publishers.enabled desc, sum(serving_stats.impressions) desc", @auth_user.account_id, session[:reports_start_date], session[:reports_end_date]])
	end

	def by_templates
		@templates = Ad.find_by_sql(["select templates.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks
			from templates
			left join serving_stats on templates.id = serving_stats.template_id
			left join ads on serving_stats.ad_id = ads.id
			left join ad_groups on ads.ad_group_id = ad_groups.id
			left join campaigns on ad_groups.campaign_id = campaigns.id
			where campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?
			group by templates.id
			order by sum(serving_stats.impressions) desc", @auth_user.account_id, session[:reports_start_date], session[:reports_end_date]])
	end

	def by_template_types
		@template_types = Ad.find_by_sql(["select template_types.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks
			from template_types
			left join templates on template_types.id = templates.type_id
			left join serving_stats on templates.id = serving_stats.template_id
			left join ads on serving_stats.ad_id = ads.id
			left join ad_groups on ads.ad_group_id = ad_groups.id
			left join campaigns on ad_groups.campaign_id = campaigns.id
			where campaigns.account_id = ? and serving_stats.time_served >= ? and serving_stats.time_served <= ?
			group by template_types.id
			order by sum(serving_stats.impressions) desc", @auth_user.account_id, session[:reports_start_date], session[:reports_end_date]])
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
end
