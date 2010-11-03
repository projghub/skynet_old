class AddAdTypeIdToAdsAndTemplates < ActiveRecord::Migration
	def self.up
		add_column :ads, :ad_type_id, :integer, :null => false
		add_index :ads, :ad_type_id
		execute("update ads set ad_type_id = template_type_id")
		remove_column :ads, :template_type_id
		add_column :templates, :ad_type_id, :integer, :null => false
		add_index :templates, :ad_type_id
		execute("update templates set ad_type_id = type_id")
		remove_column :templates, :type_id
	end

	def self.down
		add_column :templates, :type_id, :integer, :null => false
		add_index :templates, :type_id
		remove_column :templates, :ad_type_id
		add_column :ads, :template_type_id, :integer, :null => false
		add_index :ads, :template_type_id
		remove_column :ads, :ad_type_id
	end
end
