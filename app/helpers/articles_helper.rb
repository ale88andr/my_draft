module ArticlesHelper

	def format_date(date)
		"#{date.day}-#{date.month}-#{date.year} в #{date.hour}:#{date.min}"
	end
	
	def description_from(content)
		content.truncate(304, separator:' ', omission:" ... >")		
	end

end
