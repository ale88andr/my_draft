module ApplicationHelper

	def full_title(page_title)
		title = "My Draft"
		if page_title.empty?
			title
		else
			"#{title} | #{page_title}"
		end
	end

	def breadcrumbs
		breadcrumb = [link_to('MyDraft', root_path)]
		breadcrumb << link_to(c_to_format(controller_name), controller_name) if controller_name
		breadcrumb << link_to(a_to_format(action_name), "#") if action_name
		breadcrumb.join(' &gt; ')
	end

	def c_to_format(name)
		format_name = case name
			when 'articles' 		then 'Блог'
			when 'static_pages' then 'Главная'
			when 'books' 				then 'Книги'
			when 'categories' 	then 'Категории'
			else 'Не определенно'
		end
	end

	def a_to_format(name)
		format_name = case name
			when 'index' 	then 'Содержание'
			when 'show' 	then 'Просмотр'
			when 'create'	then 'Создание'
			when 'edit' 	then 'Редактирование'
			else ' '
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
