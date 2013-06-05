module ArticlesHelper

	def format_date(date)
		"#{date.day}-#{date.month}-#{date.year} в #{date.hour}:#{date.min}"
	end
	
end
