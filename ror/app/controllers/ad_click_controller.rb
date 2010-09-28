class AdClickController < ApplicationController
	def index
		stat = ServingStat.find_by_hash params[:hash]
		raise ActiveRecord::NotFound if stat.nil?
		stat.click
		stat.save
		redirect_to stat.ad.destination_url
	end
end
