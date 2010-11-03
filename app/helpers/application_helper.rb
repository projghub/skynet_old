module ApplicationHelper
	def require(html)
		"<span class=\"required\">#{html} *</span>"
	end

	def graph_labels(totals, step)
		a = []
		(0..totals.length).step(step){ |i| a << "'#{totals[i][1][:label]}'" }
		a.join(",")
	end
end
