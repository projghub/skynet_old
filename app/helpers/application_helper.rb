module ApplicationHelper
	def require(html)
		"<span class=\"required\">#{html} *</span>"
	end

	def geolocate?(ads)
		ads.each do |ad|
			return true if ad.geolocate
		end
		return false
	end

	def geolocate_replace(text)
		text = h text
		variables = {
			"city" => '<script type="text/javascript">document.write(geoip_city());</script>',
			"region" => '<script type="text/javascript">document.write(geoip_region_name());</script>',
			"region_code" => '<script type="text/javascript">document.write(geoip_region());</script>',
			"country" => '<script type="text/javascript">document.write(geoip_country_name());</script>',
			"country_code" => '<script type="text/javascript">document.write(geoip_country_code());</script>',
			"postal_code" => '<script type="text/javascript">document.write(geoip_postal_code());</script>'
		}
		variables.each do |pattern, replacement|
			text = text.gsub(/\{\{\s?#{pattern}\s?\}\}/i, replacement)
		end
		text
	end

	def graph_labels(totals, step)
		a = []
		(0..totals.length).step(step){ |i| a << "'#{totals[i][1][:label]}'" }
		a.join(",")
	end
end
