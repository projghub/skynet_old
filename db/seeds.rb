# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
display_468x60 = AdType.create(:name => "display_468x60", :label => "Banner")
display_728x90 = AdType.create(:name => "display_728x90", :label => "Leaderboard")
display_250x250 = AdType.create(:name => "display_250x250", :label => "Square")
display_200x200 = AdType.create(:name => "display_200x200", :label => "Small Square")
display_336x280 = AdType.create(:name => "display_336x280", :label => "Large Rectangle")
display_300x250 = AdType.create(:name => "display_300x250", :label => "Inline Rectangle")
display_120x600 = AdType.create(:name => "display_120x600", :label => "Skyscraper")
display_160x600 = AdType.create(:name => "display_160x600", :label => "Wide Skyscraper")
display_300x600 = AdType.create(:name => "display_300x600", :label => "Monster")
text = AdType.create(:name => "text", :label => "Text")
Template.create(:ad_type_id => display_468x60.id, :name => "Banner", :positions => 1, :width => 468, :height => 60, :file => "serve/template_1/layout")
Template.create(:ad_type_id => text.id, :name => "Text 300x250", :positions => 5, :width => 300, :height => 250, :file => "serve/template_2/layout")
Template.create(:ad_type_id => display_250x250.id, :name => "Square", :positions => 1, :width => 250, :height => 250, :file => "serve/template_3/layout")
Template.create(:ad_type_id => display_728x90.id, :name => "Leaderboard", :positions => 1, :width => 728, :height => 90, :file => "serve/template_4/layout")
Template.create(:ad_type_id => display_200x200.id, :name => "Small Square", :positions => 1, :width => 200, :height => 200, :file => "serve/template_5/layout")
Template.create(:ad_type_id => display_336x280.id, :name => "Large Rectangle", :positions => 1, :width => 336, :height => 280, :file => "serve/template_6/layout")
Template.create(:ad_type_id => display_300x250.id, :name => "Inline Rectangle", :positions => 1, :width => 300, :height => 250, :file => "serve/template_7/layout")
Template.create(:ad_type_id => display_120x600.id, :name => "Skyscraper", :positions => 1, :width => 120, :height => 600, :file => "serve/template_8/layout")
Template.create(:ad_type_id => display_160x600.id, :name => "Wide Skyscraper", :positions => 1, :width => 160, :height => 600, :file => "serve/template_9/layout")
Template.create(:ad_type_id => display_300x600.id, :name => "Monster", :positions => 1, :width => 300, :height => 600, :file => "serve/template_10/layout")
account = Account.create(:name => "Test Account", :email => "test@example.com", :enabled => true)
user = User.new(:username => "account", :password => "account", :password_confirmation => "account", :email => "test@example.com", :enabled => true)
user.account_id = account.id
user.save
