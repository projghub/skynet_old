class Template < ActiveRecord::Base
	belongs_to :type, :class_name => "TemplateType", :foreign_key => "type_id"
	has_many :serving_stats

	def select_ads
		Ad.joins(:ad_group => :campaign).where('ads.enabled = ? and campaigns.enabled = ?', true, true).order("RAND()").limit(self.positions).all
	end
end
