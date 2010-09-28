class Template < ActiveRecord::Base
	belongs_to :type, :class_name => "TemplateType"
	has_many :serving_stats

	def select_ads
		Ad.order("RANDOM()").limit(self.positions).all
	end
end
