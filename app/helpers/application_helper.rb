module ApplicationHelper

	def full_title(page_title)
		title = "My Draft"
		if page_title.empty?
			title
		else
			"#{title} | #{page_title}"
		end
	end

	# auth cancan/devise

	def resource_name
	  :user
	end


	def resource
	  @resource ||= User.new
	end


	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end

end
