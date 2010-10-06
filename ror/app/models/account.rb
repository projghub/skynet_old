class Account < ActiveRecord::Base
	has_many :campaigns
	has_many :users
end
