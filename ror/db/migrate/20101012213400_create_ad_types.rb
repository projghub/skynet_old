class CreateAdTypes < ActiveRecord::Migration
	def self.up
		create_table :ad_types do |t|
			t.string :name, :null => false
			t.string :label, :null => false
		end
		add_index :ad_types, :name, :unique => true
		execute("insert into ad_types (id, name, label) select * from template_types");
	end

	def self.down
		drop_table :ad_types
	end
end
