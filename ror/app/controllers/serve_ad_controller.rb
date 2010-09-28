class ServeAdController < ApplicationController
	layout false

	def index
		@publisher = Publisher.find_by_access_hash params[:pub]
		@template = Template.find params[:tid]
		@ads = @template.select_ads
		ServingStat.impress_ads(@publisher, @template, @ads)
		render @template.file
	end
end
