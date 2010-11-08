class AddServingStatsSpent < ActiveRecord::Migration
	def self.up
		add_column :serving_stats, :spent, :decimal, :precision => 10, :scale => 2, :null => false, :default => 0
	end

	def self.down
		remove_column :serving_stats, :spent
	end
end
