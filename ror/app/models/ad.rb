class Ad < ActiveRecord::Base
	attr_accessor :current_stat

	belongs_to :ad_group
	belongs_to :template_type
	has_many :serving_stats
end
