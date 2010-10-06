class Ad < ActiveRecord::Base
	attr_accessor :current_stat
	belongs_to :ad_group
	belongs_to :template_type
	has_many :serving_stats
	validates_presence_of :ad_group_id, :template_type_id, :title, :description_line1, :description_line2, :description, :display_url, :destination_url
end
