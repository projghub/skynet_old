class CreateAdsPublishers < ActiveRecord::Migration
	def self.up
		create_table :ads_publishers, :id => false do |t|
			t.integer :ad_id, :null => false, :primary => true
			t.integer :publisher_id, :null => false, :primary => true
		end
	end

	def self.down
		drop_table :ads_publishers
	end
end
