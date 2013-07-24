# Scenario: Manage articles list

And /^Any articles are added$/ do
	@posts = Array.new()
  3.times {@posts << FactoryGirl.create(:article)}
end

When /^I visit articles backend url$/ do
	visit backend_articles_path
	page.current_url == /backend\/articles/
end

Then /^I should see a list of articles$/ do
	within '#articles' do
		@posts.each do |post|
			page.should have_link(post.title, href: backend_article_path(post.id))
			page.should have_content(post.category.name)
			page.should have_content(post.views)
			page.should have_content('Да') if post.published == true
			page.should have_content('Нет') if post.published == false
			page.should have_link('Редактирование', href: edit_backend_article_path(post.id))
			page.should have_link('Удалить', href: backend_article_path(post))
		end
	end
end

And /^I should see new article link$/ do
	page.should have_link('Создать новую статью', new_backend_article_path)
end

And /^I should see link to unpulished articles$/ do
	page.should have_link('Статьи ожидающие публикации', backend_articles_path + '/unpublished')
end

# --end Scenario: Manage articles list

# Scenario: Visiting unpublished articles list

And /^Exists unpublished article$/ do
	@unpublished_posts = FactoryGirl.create(:article, published: false)
end

When /^I visit index articles backend page and click on unpublished articles link$/ do
	visit backend_articles_path
	within '#articles' do
		page.click_link('Статьи ожидающие публикации')
	end
end

And /^I should see link to all articles$/ do
	within '#articles' do
		page.should have_link('Все статьи', href: backend_articles_path)
		page.should_not have_link('Статьи ожидающие публикации', backend_articles_path + '/unpublished')
	end
end

And /^I should see unpublished article$/ do
	within '#articles' do
		page.should have_link(@unpublished_posts.title, href: backend_article_path(@unpublished_posts.id))
	end
end

But /^I should not see published articles$/ do
	within '#articles' do
		@posts.each do |post|
			page.should_not have_link(post.title, href: backend_article_path(post.id))
		end
	end
end

# --end Scenario: Visiting unpublished articles list

# Scenario: Detail view of a single article

When /^I visited show page of backend article module$/ do
	visit article_path(@post.first.id)
end

And /^I should see editind and destroy links$/ do
	page.should have_link('Редактировать', href: edit_backend_article_path(@post.first.id))
	page.should have_link('Удалить статью', href: backend_article_path(@post.first.id))
end

# --end Scenario: Detail view of a single article

# Scenario: Editing a single article

And /^I should see edit (.+) link$/ do |title|
	within '#articles' do
		page.should have_content(title)
		page.should have_link('Редактирование', href: edit_backend_article_path(@post.first.id))
	end
end

And /^I click on edit (.+) link$/ do |title|
	page.find_link('Редактирование').click
	page.current_path == edit_backend_article_path(@post.first.id)
end

Then /^I should see editind form with (.+) values$/ do |title|
	page.should have_content("Редактирование статьи '#{title}'")
	within "#edit_article_#{@post.first.id}" do
		page.find_field('Заголовок статьи :').value == @post.first.title
		page.find_field('Содержание статьи :').value == @post.first.content
		page.find_field('Выберите категорию :').value == @post.first.category.name
		page.find('#article_published').should be_checked if @post.first.published == true
	end
end

And /^I should see saving button$/ do
	page.should have_button('Сохранить')
end

# --end Scenario: Editing a single article

# Scenario: Save editing values to article

And /^I visit edit articles backend url$/ do
	visit edit_backend_article_path(@post.first.id)
	page.current_url == /backend\/articles\/"#{@post.first.id}"\/edit/
end

When /^I feeling (.+), as title (.+), as content changes into editing form$/ do |title, content|
	within "#edit_article_#{@post.first.id}" do
		fill_in('article[title]', with: title)
		fill_in('article[content]', with: content)
		#select('Программирование', from: 'article_category_id')
	end
end

And /^I click on save button$/ do
	click_button("Сохранить")
end

Then /^Article with title (.+) and content (.+) should exists$/ do |title, content|
	expect(Article.find_by_title(title)).not_to be_nil
	expect(Article.find_by_content(content)).not_to be_nil
	expect(Article.find_by_title(@post.first.title)).to be_nil
end

And /^I should see message confirmation message$/ do
	expect(page.find('.notice').text).to eq('Сообщение: Статья обновленна.')
end

And /^I should see (.+) article in list of article$/ do |title|
	step "I visit articles backend url"
	within '#articles' do
		expect(page).to have_link(title, href: backend_article_path(@post.first.id))
		expect(page).not_to have_link(@post.first.title)
	end
end

# --end Scenario: Save editing values to article

# Scenario: Save editing values to article with invalid data

When /^I feeling article with empty title$/ do
	within "#edit_article_#{@post.first.id}" do
		fill_in('article[title]', with: '')
	end
end

Then /^Article should not be changed$/ do
	expect(Article.find_by_title(@post.first.title)).not_to be_nil
end

And /^I should redirect to editing form with error message$/ do
	expect(page.find('span.error').text).to eq('Сообщение: При обновлении статьи возникли ошибки')
	within '#error_explanation' do
		expect(page.find('.error').text).to eq('Title - Это поле не должно быть пустым')
	end
end

# --end Scenario: Save editing values to article with invalid data

# Scenario: Create article with valid params

And /^Click new article link$/ do
	page.find_link('Создать новую статью').click
	expect(page.current_path).to eq(new_backend_article_path)
end

Then /^I should see form for adding new article$/ do
	expect(page).to have_content('> Создание новой статьи')
	within '#new_article' do
		expect(page.find_field('Заголовок статьи :')).not_to be_nil
		expect(page.find_field('Содержание статьи :')).not_to be_nil
		expect(page.find_field('Выберите категорию :')).not_to be_nil
		expect(page.find('#article_published')).not_to be_nil
		find(:xpath, "//select[@id = 'article_category_id']/option[text() = 'Программирование']")
		Tag.all.each_with_index do |tag, index|
			expect(find(:xpath, "//input[@id = 'article_tag_ids_'][#{index + 1}]")).not_to be_nil
			page.should have_content(tag.name)
		end
		expect(page.find_button('Сохранить')).not_to be_nil
	end
end

And /^I feeling (.+), as title (.+), as content, (.+) as category into new form$/ do |title, content, category|
	expect(page).to have_content('> Создание новой статьи')
	within "#new_article" do
		fill_in('article[title]', with: title)
		fill_in('article[content]', with: content)
		select("Программирование", from: "article[category_id]")
	end
end

Then /^New article must be added to the database when I click on save button$/ do
	expect{click_button("Сохранить")}.to change(Article, :count).by(1)
end

And /^I should redirect to show (.+) page with successfully message$/ do |title|
	expect(page.current_path).to eq article_path(Article.find_by_title(title).id)
	expect(page.find('.notice').text).to eq('Сообщение: Статья была успешно созданна.')
end

And /^I should not see (.+) in the list of article$/ do |title|
	visit articles_path
	page.should_not have_content(title)
end

But /^If I visit backend unpublished articles list (.+) should be there$/ do |title|
	visit unpublished_backend_articles_path
	page.should have_link(title)
end

# --end Scenario: Create article with valid params

# Scenario: Create article with invalid params

Given /^I am a registered user visiting new articles link$/ do
	step "I am a registered user"
	visit new_backend_article_path
	page.current_url =~ /backend\/articles\/new/
end

When /^I try save empty fields of title and content$/ do
	expect(page).to have_content('> Создание новой статьи')
	within "#new_article" do
		fill_in('article[title]', with: '')
		fill_in('article[content]', with: '')
		select("Программирование", from: "article[category_id]")
	end
end

Then /^Article should no to be added to the database$/ do
	expect{click_button "Сохранить"}.not_to change(Article, :count)
end

And /^I should redirect to new article form page with error message$/ do
	expect(page.current_path).to eq backend_articles_path
	expect(find('span.error').text).to eq "Сообщение: При создании новой статьи возникли ошибки"
	within '#error_explanation' do
		expect(all('.error')).not_to be_nil
		expect(all('.error')[1].text).to eq "Title - Это поле не должно быть пустым"
		expect(all('.error')[0].text).to eq "Content - Это поле должно содержать данные"
	end
end

# --end Scenario: Create article with invalid params

# Scenario: Delete single article

When /^I click on delete article link article (.+) should be delete from database$/ do |title|
	expect(page.current_path).to eq backend_articles_path
	within "#articles" do
		expect(page.find_link('Удалить', href: backend_article_path(@post.first.id))).not_to be_nil
	end
	expect{ click_link 'Удалить' }.to change(Article, :count).by(-1)
	expect( Article.find_by_title(title) ).to be_nil
end

Then /^I should redirect to articles list and article (.+) is no find$/ do |title|
	expect(page.current_path).to eq backend_articles_path
	page.should_not have_content title
end

# --end Scenario: Delete single article