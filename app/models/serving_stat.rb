class ServingStat < ActiveRecord::Base
	SALT = "skynet"

	belongs_to :publisher
	belongs_to :template
	belongs_to :ad

	def self.impress_ads(publisher, template, ads)
		now = ServingStat.time_now
		position = 0
		ads.each do |ad|
			position += 1
			stat = ServingStat.where("publisher_id = ? AND template_id = ? AND ad_id = ? AND position = ? AND time_served = ?", publisher.id, template.id, ad.id, position, now.to_i).first(:lock => true)
			if stat.nil?
				stat = ServingStat.new(:publisher => publisher, :template => template, :ad => ad, :time_served => now.to_i, :position => position, :impressions => 0, :clicks => 0)
				stat.assign_hash
			end
			stat.impress
			stat.save
			ad.current_stat = stat
		end
	end

	def self.time_now
		Time.at((Time.now.getutc.to_i / 3600) * 3600).getutc
	end

	def self.build_hash(stat)
		Digest::SHA1.hexdigest(
			ServingStat::SALT+
			("%011d" % stat.publisher_id)+
			("%011d" % stat.template_id)+
			("%011d" % stat.ad_id)+
			("%011d" % stat.position)+
			("%011d" % stat.time_served)
		)
	end

	def assign_hash
		self.hash = ServingStat.build_hash(self)
	end

	def impress
		self.impressions += 1
		self.spent += self.ad.bid.to_f if self.ad.bid_type.name == "cpm"
	end

	def click
		self.clicks += 1
	end
end
