class CreateAdsPublishers < ActiveRecord::Migration
	def self.up
		create_table :ads_publishers, :id => false do |t|
			t.integer :ad_id, :null => false
			t.integer :publisher_id, :null => false
		end
		add_index :ads_publishers, [:ad_id, :publisher_id], :name => "ad_id_publisher_id_index", :unique => true
	end

	def self.down
		drop_table :ads_publishers
	end
end
