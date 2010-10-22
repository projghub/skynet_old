module ApplicationHelper
	def require(html)
		"<span class=\"required\">#{html} *</span>"
	end
end
