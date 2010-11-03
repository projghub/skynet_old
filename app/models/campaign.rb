class Campaign < ActiveRecord::Base
	attr_protected :account_id
	belongs_to :account
	has_many :ad_groups
	has_many :ads, :through => :ad_groups
	validates_presence_of :name, :account_id
	validate :valid_no_ads
	default_scope where(:deleted_at => nil)

	def valid_no_ads
		errors.add :deleted_at, "cannot have available ad groups or ads when deleting a campaign" unless self.deleted_at.nil? || (self.ad_groups.size == 0 && self.ads.size == 0)
	end
end
