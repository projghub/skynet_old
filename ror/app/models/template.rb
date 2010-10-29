class Template < ActiveRecord::Base
	belongs_to :ad_type
	has_many :serving_stats

	def select_ads(attr_filter)
		q = Ad.joins(:ad_group => {:campaign => :account}).where('ads.enabled = ? and campaigns.enabled = ? and accounts.enabled = ? and ads.ad_type_id = ?', true, true, true, self.ad_type_id).order("RAND()").limit(self.positions)
		if attr_filter.kind_of? Hash
			q = q.joins(:attribute_values => :attribute)
			attr_filter.each do |name,values|
				q = q.where("attributes.name = ? and attribute_values.value IN (?)", name, values.split(","))
			end
		end
		q.all
	end
end
