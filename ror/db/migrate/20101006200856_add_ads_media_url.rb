class AddAdsMediaUrl < ActiveRecord::Migration
	def self.up
		add_column :ads, :media_url, :string, :null => false
	end

	def self.down
		remove_column :ads, :media_url
	end
end
