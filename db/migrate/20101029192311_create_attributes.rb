class CreateAttributes < ActiveRecord::Migration
	def self.up
		create_table :attributes do |t|
			t.string :name, :null => false
			t.string :label, :null => false
			t.timestamps
		end
		add_index :attributes, [:name], :name => "name_index", :unique => true
	end

	def self.down
		drop_table :attributes
	end
end
