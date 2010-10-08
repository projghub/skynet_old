class Ad < ActiveRecord::Base
	attr_accessor :current_stat, :user_account_id
	attr_protected :current_stat, :user_account_id
	belongs_to :ad_group
	belongs_to :template_type
	has_many :serving_stats
	validates_presence_of :ad_group_id, :template_type_id, :title, :description_line1, :description_line2, :description, :display_url, :destination_url
	validate :valid_ad_group_id

	def valid_ad_group_id
		errors.add :ad_group_id, "must be valid" unless !user_account_id.nil? && AdGroup.find(self.ad_group_id).campaign.account_id == user_account_id
	end
end
