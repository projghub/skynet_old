module ReportsHelper
	def format_utc(time, format)
		Time.at(time).getutc.strftime(format)
	end
end
