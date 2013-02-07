class CreateAdTypes < ActiveRecord::Migration
	def self.up
		create_table :ad_types do |t|
			t.string :name, :null => false
			t.string :label, :null => false
		end
	end

	def self.down
		drop_table :ad_types
	end
end
