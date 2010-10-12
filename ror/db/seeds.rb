# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
display = TemplateType.create(:name => "display_468x60", :label => "Banner")
display = TemplateType.create(:name => "display_728x90", :label => "Leaderboard")
display = TemplateType.create(:name => "display_250x250", :label => "Square")
display = TemplateType.create(:name => "display_200x200", :label => "Small Square")
display = TemplateType.create(:name => "display_336x280", :label => "Large Rectangle")
display = TemplateType.create(:name => "display_300x250", :label => "Inline Rectangle")
display = TemplateType.create(:name => "display_120x600", :label => "Skyscraper")
display = TemplateType.create(:name => "display_160x600", :label => "Wide Skyscraper")
display = TemplateType.create(:name => "display_300x600", :label => "Monster")
text = TemplateType.create(:name => "text", :label => "Text")
Template.create(:type_id => display.id, :name => "Banner", :positions => 1, :width => 468, :height => 60, :file => "serve/template_1/layout")
Template.create(:type_id => text.id, :name => "Text 300x250", :positions => 5, :width => 300, :height => 250, :file => "serve/template_2/layout")
account = Account.create(:name => "Test Account", :email => "test@example.com", :enabled => true)
user = User.new(:username => "account", :password => "account", :password_confirmation => "account", :email => "test@example.com", :enabled => true)
user.account_id = account.id
user.save
