class Publisher < ActiveRecord::Base
	attr_protected :access_hash
	has_many :serving_stats
	has_and_belongs_to_many :ads
	validates_presence_of :name
	after_validation :set_access_hash
	default_scope where(:deleted_at => nil)

	def set_access_hash
		self.access_hash ||= Digest::SHA1.hexdigest(Time.now.to_s+self.name)
	end
end
