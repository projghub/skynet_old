# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
display = TemplateType.create(:name => "display")
text = TemplateType.create(:name => "text")
mobile = TemplateType.create(:name => "mobile")
Template.create(:type_id => display.id, :name => "Banner", :positions => 3, :width => 468, :height => 60, :file => "serve/template_1/layout")
