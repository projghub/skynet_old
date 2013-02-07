class CreateTemplateTypes < ActiveRecord::Migration
	def self.up
		create_table :template_types do |t|
			t.string :name, :null => false
      t.string :label
		end
	end

	def self.down
		drop_table :template_types
	end
end
