class AdGroup < ActiveRecord::Base
	belongs_to :campaign
	has_many :ads
end
