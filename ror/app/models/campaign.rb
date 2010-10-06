class Campaign < ActiveRecord::Base
	belongs_to :account
	has_many :ad_groups
	validates_presence_of :name
end
