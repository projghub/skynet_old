class CreateAccounts < ActiveRecord::Migration
	def self.up
		create_table :accounts do |t|
			t.string :name, :null => false
			t.string :email, :null => false
			t.boolean :enabled, :null => false

			t.timestamps
		end
		add_index :accounts, [:enabled]
	end

	def self.down
		drop_table :accounts
	end
end
