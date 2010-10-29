class Ad < ActiveRecord::Base
	attr_accessor :current_stat, :user_account_id
	attr_protected :current_stat, :user_account_id, :attribute_values
	belongs_to :ad_group
	belongs_to :ad_type
	has_attached_file :media,
		:path => ":rails_root/public/assets/ads/:id/:style/:filename",
		:url => "/assets/ads/:id/:style/:filename"
	has_many :serving_stats
	has_and_belongs_to_many :attribute_values
	validates_presence_of :ad_group_id, :ad_type_id, :title, :description_line1, :description_line2, :description, :destination_url
	validate :valid_ad_group_id
	default_scope where(:deleted_at => nil)

	def valid_ad_group_id
		errors.add :ad_group_id, "must be valid" unless !user_account_id.nil? && AdGroup.find(self.ad_group_id).campaign.account_id == user_account_id
	end

	def attribute_value_ids=(attribute_value_ids)
		attribute_value_ids.each do |id|
			attribute_value = AttributeValue.find(id) rescue nil
			unless attribute_value.nil?
				self.attribute_values << attribute_value
			end
		end
	end

	def has_attribute_value(attribute_value)
		self.attribute_values.each do |av|
			return true if av == attribute_value
		end
		return false
	end
end
