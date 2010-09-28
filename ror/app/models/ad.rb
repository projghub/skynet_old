class Ad < ActiveRecord::Base
	attr_accessor :current_stat

	belongs_to :ad_group
	belongs_to :template_type
	has_many :serving_stats

	def build_click_url
		"http://localhost:3000/ad_click?hash=#{self.current_stat.hash}"
	end
end
