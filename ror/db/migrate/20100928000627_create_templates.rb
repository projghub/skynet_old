class CreateTemplates < ActiveRecord::Migration
	def self.up
		create_table :templates do |t|
			t.integer :type_id, :null => false
			t.string :name, :null => false
			t.integer :positions, :null => false
			t.integer :width, :null => false
			t.integer :height, :null => false
			t.string :file, :null => false

			t.timestamps
		end
	end

	def self.down
		drop_table :templates
	end
end
