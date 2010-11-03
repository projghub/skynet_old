class AttributeValue < ActiveRecord::Base
	belongs_to :attribute
	has_and_belongs_to_many :ads
end
