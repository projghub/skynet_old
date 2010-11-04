class AddAdsGeolocate < ActiveRecord::Migration
	def self.up
		add_column :ads, :geolocate, :boolean, :null => false, :default => false
	end

	def self.down
		remove_column :ads, :geolocate
	end
end
