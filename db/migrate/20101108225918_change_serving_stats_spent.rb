class ChangeServingStatsSpent < ActiveRecord::Migration
	def self.up
		change_column :serving_stats, :spent, :decimal, :precision => 13, :scale => 5, :null => false
	end

	def self.down
		change_column :serving_stats, :spent, :decimal, :precision => 10, :scale => 2, :null => false
	end
end
