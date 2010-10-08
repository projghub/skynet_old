class ReportsController < ApplicationController
	def index
		redirect_to :controller => "reports", :action => "by_campaigns"
	end

	def by_campaigns
	end

	def by_ad_groups
	end

	def by_ads
		@ads = Ad.find_by_sql("select ads.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks from ads left join serving_stats on ads.id = serving_stats.ad_id group by serving_stats.ad_id order by ads.enabled desc, sum(serving_stats.impressions) desc")
	end

	def by_publishers
		@publishers = Ad.find_by_sql("select publishers.*, sum(serving_stats.impressions) impressions, sum(serving_stats.clicks) clicks from publishers left join serving_stats on publishers.id = serving_stats.publisher_id group by serving_stats.publisher_id order by publishers.enabled desc, sum(serving_stats.impressions) desc")
	end

	def by_templates
	end

	def by_template_types
	end
end
