class CreateCampaigns < ActiveRecord::Migration
	def self.up
		create_table :campaigns do |t|
			t.string :name, :null => false
			t.boolean :enabled, :null => false

			t.timestamps
		end
	end

	def self.down
		drop_table :campaigns
	end
end
