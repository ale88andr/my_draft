module UsersHelper

	#  permission helper method
	#  @return user permission
	def perms(permission_id)
		permission = case permission_id
			when 1 
				"Администратор"
			when 2
				"Модератор"
			when 3
				"Пользователь"		 		
		end
	end

	# сheking show_email users
	# @return status string if field in table "users" false/true
	def check_email_show(email)
		is_email_show = email === true ? "Email доступен другим пользователям" : "Email недоступен другим пользователям"
	end

	def format_date(date)
		"#{date.day}-#{date.month}-#{date.year} в #{date.hour}:#{date.min}"
	end

end
