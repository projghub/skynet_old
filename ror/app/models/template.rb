class Template < ActiveRecord::Base
	belongs_to :ad_type
	has_many :serving_stats

	def select_ads
		Ad.joins(:ad_group => :campaign).where('ads.enabled = ? and campaigns.enabled = ? and ads.ad_type_id = ?', true, true, self.ad_type_id).order("RAND()").limit(self.positions).all
	end
end
