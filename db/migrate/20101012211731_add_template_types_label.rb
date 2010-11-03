class AddTemplateTypesLabel < ActiveRecord::Migration
	def self.up
		add_column :template_types, :label, :string, :null => false
	end

	def self.down
		remove_column :template_types, :label
	end
end
