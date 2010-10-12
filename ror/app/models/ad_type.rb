class AdType < ActiveRecord::Base
	has_many :ads
	has_many :templates
end
