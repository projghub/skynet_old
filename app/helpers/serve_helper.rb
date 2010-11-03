module ServeHelper
	def build_click_url(ad)
		url_for :controller => "click", :action => "index", :hash => ad.current_stat.hash
	end
end
