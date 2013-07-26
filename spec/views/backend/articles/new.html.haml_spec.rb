require 'spec_helper'

describe "backend/articles/new" do

	include Devise::TestHelpers

	before (:each) do
		tags, categories = [], []
		tags << FactoryGirl.create(:tag)
		categories << FactoryGirl.create(:category)
		article = mock_model('Article').as_new_record.as_null_object
		assign(:article, article)
		assign(:categories, categories)
		assign(:tags, tags)
		render
	end

	it "should render new template" do
		expect(view).to render_template(partial: 'backend/articles/_form')
	end

	it "should contain header" do
		expect(rendered).to have_content('> Создание новой статьи')
	end

	context "rendered template should contain form with fields" do
  	
		it "should contain title field" do
			expect(rendered).to have_selector('#article_title')
		end

		it "should contain content field" do
			expect(rendered).to have_selector('#article_content')
		end

		it "should contain categories field" do
			expect(rendered).to have_selector('#article_category_id')
		end

		it "should contain tags field" do
			expect(rendered).to have_selector('#article_tag_ids_')
		end

		it "should contain submit button" do
			expect(rendered).to have_button('Сохранить')
		end

	end

end