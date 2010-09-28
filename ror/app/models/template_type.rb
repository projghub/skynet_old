class TemplateType < ActiveRecord::Base
	has_many :ads
	has_many :templates, :foreign_key => "type_id"
end
