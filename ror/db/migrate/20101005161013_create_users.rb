class CreateUsers < ActiveRecord::Migration
	def self.up
		create_table :users do |t|
			t.integer :account_id, :null => false
			t.string :username, :null => false
			t.string :password_hash, :null => false
			t.string :salt, :null => false
			t.string :email, :null => false
			t.boolean :enabled, :null => false

			t.timestamps
		end
		add_index :users, [:account_id]
		add_index :users, [:username], :unique => true
		add_index :users, [:username, :enabled], :unique => true
	end

	def self.down
		drop_table :users
	end
end
