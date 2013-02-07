class CreateAds < ActiveRecord::Migration
	def up
		create_table :ads do |t|
			t.integer :ad_group_id, :null => false
      t.integer :ad_type_id
			t.string :title, :null => false
			t.string :description_line1, :null => false
			t.string :description_line2, :null => false
			t.string :description, :null => false
			t.string :display_url, :null => false
			t.string :destination_url, :null => false
      t.string :media_url
      t.integer :bid_type_id, null: false
      t.decimal :bid, precision: 10, scale: 2, null: false
      t.decimal :daily_limit
			t.boolean :enabled, :null => false

			t.timestamps
		end
	end

	def down
		drop_table :ads
	end
end
