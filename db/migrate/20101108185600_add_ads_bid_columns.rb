class AddAdsBidColumns < ActiveRecord::Migration
	def self.up
		add_column :ads, :bid_type_id, :integer, :null => false
		add_column :ads, :bid, :decimal, :precision => 10, :scale => 2, :null => false
		add_column :ads, :daily_limit, :decimal, :precision => 10, :scale => 2, :null => false
		add_index :ads, [:bid_type_id], :name => "bid_type_id_index"
	end

	def self.down
		remove_column :ads, :daily_limit
		remove_column :ads, :bid
		remove_column :ads, :bid_type_id
	end
end
