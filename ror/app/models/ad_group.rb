class AdGroup < ActiveRecord::Base
	belongs_to :campaign
	has_many :ads
	validates_presence_of :name, :campaign_id
end
