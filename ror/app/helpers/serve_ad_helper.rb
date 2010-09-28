module ServeAdHelper
	def build_click_url(ad)
		url_for :controller => "ad_click", :action => "index", :hash => ad.current_stat.hash
	end
end
