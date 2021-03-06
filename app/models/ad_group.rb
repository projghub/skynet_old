class AdGroup < ActiveRecord::Base
	attr_accessor :user_account_id
	attr_protected :user_account_id
	belongs_to :campaign
	has_many :ads
	validates_presence_of :name, :campaign_id
	validate :valid_campaign_id
	validate :valid_no_ads
	default_scope where(:deleted_at => nil)

	def valid_campaign_id
		errors.add :campaign_id, "must be valid" unless !user_account_id.nil? && Campaign.find(self.campaign_id).account_id == user_account_id
	end

	def valid_no_ads
		errors.add :deleted_at, "cannot have available ads when deleting an ad group" unless self.deleted_at.nil? || self.ads.size == 0
	end
end
