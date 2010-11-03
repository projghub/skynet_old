class CreateServingStats < ActiveRecord::Migration
  def self.up
    create_table :serving_stats do |t|
      t.integer :publisher_id, :null => false
      t.integer :template_id, :null => false
      t.integer :ad_id, :null => false
      t.integer :position, :null => false
      t.integer :time_served, :null => false
      t.integer :impressions, :null => false
      t.integer :clicks, :null => false
      t.string :hash, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :serving_stats
  end
end
