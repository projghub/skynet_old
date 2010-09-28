class CreatePublishers < ActiveRecord::Migration
	def self.up
		create_table :publishers do |t|
			t.string :name, :null => false
			t.string :website, :null => false
			t.string :phone, :null => false
			t.string :contact_name, :null => false
			t.string :access_hash, :null => false
			t.boolean :enabled, :null => false

			t.timestamps
		end
	end

	def self.down
		drop_table :publishers
	end
end
