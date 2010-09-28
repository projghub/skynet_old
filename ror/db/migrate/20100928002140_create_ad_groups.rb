class CreateAdGroups < ActiveRecord::Migration
	def self.up
		create_table :ad_groups do |t|
			t.string :name, :null => false
			t.integer :campaign_id, :null => false

			t.timestamps
		end
	end

	def self.down
		drop_table :ad_groups
	end
end
