class AddAccountIdToTables < ActiveRecord::Migration
	def self.up
		add_column :campaigns, :account_id, :integer, :null => false
		add_index :campaigns, [:account_id]
	end

	def self.down
		remove_column :campaigns, :account_id
	end
end
