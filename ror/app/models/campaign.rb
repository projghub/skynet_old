class Campaign < ActiveRecord::Base
	attr_protected :account_id
	belongs_to :account
	has_many :ad_groups
	validates_presence_of :name, :account_id
end
