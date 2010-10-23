class AddDeletedAtColumns < ActiveRecord::Migration
	def self.up
		add_column :ads, :deleted_at, :datetime, :null => true, :default => nil
		add_column :ad_groups, :deleted_at, :datetime, :null => true, :default => nil
		add_column :campaigns, :deleted_at, :datetime, :null => true, :default => nil
		add_column :publishers, :deleted_at, :datetime, :null => true, :default => nil
		add_column :users, :deleted_at, :datetime, :null => true, :default => nil
	end

	def self.down
		remove_column :ads, :deleted_at
		remove_column :ad_groups, :deleted_at
		remove_column :campaigns, :deleted_at
		remove_column :publishers, :deleted_at
		remove_column :users, :deleted_at
	end
end
