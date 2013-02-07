class AddAccountIdToTables < ActiveRecord::Migration
	def up
		add_column :campaigns, :account_id, :integer
	end

	def down
		remove_column :campaigns, :account_id
	end
end
