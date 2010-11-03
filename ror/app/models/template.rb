class Template < ActiveRecord::Base
	belongs_to :ad_type
	belongs_to :base_ad, :class_name => "Ad", :foreign_key => "base_ad_id"
	has_many :serving_stats

	def select_ads(attr_filter)
		q = Ad.joins(:ad_group => {:campaign => :account}).where('ads.enabled = ? and campaigns.enabled = ? and accounts.enabled = ? and ads.ad_type_id = ?', true, true, true, self.ad_type_id).order("RAND()").limit(self.positions)
		if attr_filter.kind_of? Hash
			attr_filter.each do |name,values|
				q = q.where("exists (select ads_attribute_values.ad_id from ads_attribute_values left join attribute_values on ads_attribute_values.attribute_value_id = attribute_values.id left join attributes on attribute_values.attribute_id = attributes.id where ads_attribute_values.ad_id = ads.id and attributes.name = ? and attribute_values.value IN (?))", name, values.split(","))
			end
		end
		ads = q.all
		if !self.base_ad.nil? && ads.length < self.positions
			(self.positions - ads.length).times do |i|
				ads << self.base_ad(:first)
			end
		end
		ads
	end
end
