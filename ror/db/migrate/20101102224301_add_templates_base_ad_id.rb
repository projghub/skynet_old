class AddTemplatesBaseAdId < ActiveRecord::Migration
	def self.up
		add_column :templates, :base_ad_id, :integer, :default => nil
		add_index :templates, :base_ad_id, :name => "base_ad_id_index"
	end

	def self.down
		remove_column :templates, :base_ad_id
	end
end
