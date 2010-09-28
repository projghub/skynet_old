class CreateAds < ActiveRecord::Migration
	def self.up
		create_table :ads do |t|
			t.integer :ad_group_id, :null => false
			t.integer :template_type_id, :null => false
			t.string :title, :null => false
			t.string :description_line1, :null => false
			t.string :description_line2, :null => false
			t.string :description, :null => false
			t.string :display_url, :null => false
			t.string :destination_url, :null => false
			t.boolean :enabled, :null => false

			t.timestamps
		end
	end

	def self.down
		drop_table :ads
	end
end
