class Ad < ActiveRecord::Base
	attr_accessor :current_stat, :user_account_id, :attribute_value_ids, :publisher_ids
	attr_protected :current_stat, :user_account_id, :attribute_values, :publishers
	belongs_to :ad_group
	belongs_to :ad_type
	has_attached_file :media,
		:path => ":rails_root/public/assets/ads/:id/:style/:filename",
		:url => "/assets/ads/:id/:style/:filename"
	has_many :serving_stats
	has_and_belongs_to_many :attribute_values
	has_and_belongs_to_many :publishers
	has_many :base_for_templates, :class_name => "Template", :foreign_key => "base_ad_id"
	validates_presence_of :ad_group_id, :ad_type_id, :title, :description_line1, :description_line2, :description, :destination_url
	validate :valid_ad_group_id
	before_update :save_attribute_value_ids, :save_publisher_ids
	default_scope where(:deleted_at => nil)

	def valid_ad_group_id
		errors.add :ad_group_id, "must be valid" unless !user_account_id.nil? && AdGroup.find(self.ad_group_id).campaign.account_id == user_account_id
	end

	def has_attribute_value(attribute_value)
		self.attribute_values.each do |av|
			return true if av.id == attribute_value.id
		end
		return false
	end

	def has_publisher(publisher)
		self.publishers.each do |p|
			return true if p.id == publisher.id
		end
		return false
	end

	def daily_totals(start_offset = 30, end_offset = 0)
		now = Time.now.getutc
		tmp_start = now - (start_offset * 86400)
		tmp_end = now - (end_offset * 86400)
		start_time = Time.utc(tmp_start.year, tmp_start.month, tmp_start.day)
		end_time = Time.utc(tmp_end.year, tmp_end.month, tmp_end.day, 23, 59, 59)
		totals = {}
		ServingStat.select("serving_stats.time_served as time_served, sum(serving_stats.impressions) as impressions, sum(serving_stats.clicks) as clicks").where("serving_stats.time_served >= ? and serving_stats.time_served <= ? and serving_stats.ad_id = ?", start_time.to_i, end_time.to_i, self.id).group("serving_stats.ad_id, serving_stats.time_served div 86400").all.each do |stat|
			totals[Time.at(stat.time_served.to_i).getutc.strftime("%Y-%m-%d")] = {:label => Time.at(stat.time_served.to_i).getutc.strftime("%e"), :value => (stat.impressions.to_f > 0.0 ? stat.clicks.to_f / stat.impressions.to_f : 0.0)}
		end
		(start_time.to_i..end_time.to_i).step(86400).each do |i|
			totals[Time.at(i).getutc.strftime("%Y-%m-%d")] ||= {:label => Time.at(i).getutc.strftime("%e"), :value => 0.0}
		end
		totals.sort
	end

	def save_attribute_value_ids
		attribute_values = []
		attribute_value_ids.each do |id|
			attribute_value = AttributeValue.find(id) rescue nil
			unless attribute_value.nil?
				attribute_values << attribute_value
			end
		end
		self.attribute_values = attribute_values
	end

	def save_publisher_ids
		publishers = []
		publisher_ids.each do |id|
			publisher = Publisher.find(id) rescue nil
			unless publisher.nil?
				publishers << publisher
			end
		end
		self.publishers = publishers
	end
end
