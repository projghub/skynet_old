class ServeController < ApplicationController
	layout false

	def index
		@publisher = Publisher.find_by_access_hash_and_enabled params[:pub], true
		raise ActiveRecord::RecordNotFound if @publisher.nil?
		@template = Template.find params[:tid]
		@ads = @template.select_ads
		ServingStat.impress_ads(@publisher, @template, @ads)
		render @template.file
	end
end
