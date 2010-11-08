class CreateBidTypes < ActiveRecord::Migration
	def self.up
		create_table :bid_types do |t|
			t.string :name, :null => false
			t.string :label, :null => false
			t.timestamps
		end
	end

	def self.down
		drop_table :bid_types
	end
end
