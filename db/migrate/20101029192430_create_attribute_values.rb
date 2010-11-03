class CreateAttributeValues < ActiveRecord::Migration
	def self.up
		create_table :attribute_values do |t|
			t.integer :attribute_id, :null => false
			t.string :value, :null => false
			t.string :label, :null => false
			t.timestamps
		end
		add_index :attribute_values, [:attribute_id, :value], :name => "attribute_id_value_index", :unique => true
	end

	def self.down
		drop_table :attribute_values
	end
end
