class Publisher < ActiveRecord::Base
	attr_protected :access_hash
	has_many :serving_stats
	validates_presence_of :name, :website, :phone, :contact_name
	after_validation :set_access_hash

	def set_access_hash
		self.access_hash ||= Digest::SHA1.hexdigest(Time.now.to_s+self.name)
	end
end
