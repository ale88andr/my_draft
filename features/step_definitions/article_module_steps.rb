# Scenario: Any user should see a list of existing articles

And /^Articles (.+) existing$/ do |titles|
  user = FactoryGirl.create(:user)
  category = FactoryGirl.create(:category)
  @post = []
  titles.split(',').each do |title|
    article = Article.new(title: title, content: 'article content', published: true, views: 1)
    article.user_id = user.id
    article.category_id = category.id
    article.save!
    @post << article
  end
end

When /^I visiting index page of article module$/ do
  visit articles_path
  page.current_url.should =~ /articles/
end

Then /^I should see a list of (.+) articles with nav elements$/ do |titles|
  titles.split(',').each_with_index do |title, index|
    #post = Article.find_by_title(title)

    page.should have_content(@post[index].title)
    page.should have_link(@post[index].title, href: article_path(@post[index].id))
    page.should have_link(@post[index].category.name, href: category_path(@post[index].category_id))
    page.should have_content(@post[index].views)

  end
end

# --end Scenario: Any user should see a list of existing articles

# Scenario: Any user should see a detail view of a single article

And /^I am a guest user which visited index page of article module$/ do
  step "I visiting index page of article module"
  page.should have_link(@post.first.title, article_path(@post.first))
end

When /^I click to detail view link$/ do
  page.find_link(@post.first.title).click
end

Then /^I should see a detail article view$/ do
  page.should have_content(@post.first.title)
  page.should have_content(@post.first.content)
  page.should have_content(@post.first.views)
  page.should have_content(@post.first.category.name)
end

# --end Scenario: Any user should see a detail view of a single article

# Scenario: A guest user should not see an adding comment form

When /^I visit detail article view link$/ do
  visit article_path(@post.first)
end

Then /^I should see a detail article view without add comment form$/ do
  step "I should see a detail article view"
  page.should_not have_css('form#new_comment')
  page.should_not have_content('Отправить комментарий')

  page.should have_content('Вы не можете оставлять комментарии, Войдите под своим именем или Зарегистрируйтесь')
end

# --end Scenario: A guest user should not see an adding comment form

# Scenario: A registered user should see adding comment form

And /^I am a registered user$/ do
  visit new_user_session_path
  filling_signin_form('oQo','11111111')
  click_button("Войти")
end

Then /^I should see a detail article view with add comment form$/ do
  step "I should see a detail article view"
  page.should have_css('form#new_comment')
  page.find_button('Отправить комментарий')

  page.should_not have_content('Вы не можете оставлять комментарии, Войдите под своим именем или Зарегистрируйтесь')
end

# --end Scenario: A registered user should see adding comment form