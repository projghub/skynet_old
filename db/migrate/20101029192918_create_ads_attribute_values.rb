class CreateAdsAttributeValues < ActiveRecord::Migration
	def self.up
		create_table :ads_attribute_values, :id => false do |t|
			t.integer :ad_id, :null => false
			t.integer :attribute_value_id, :null => false
		end
		add_index :ads_attribute_values, [:ad_id, :attribute_value_id], :name => "ad_id_attribute_value_id_index", :unique => true
	end

	def self.down
		drop_table :ads_attribute_values
	end
end
