require 'spec_helper'

describe "articles/new.html.haml" do

  before (:each) do
		article = mock_model("Article").as_new_record.as_null_object
		assign(:article, article)
		render
	end

  it "should render new template" do
  	expect(view).to render_template(partial: 'new')
  end

  it "should contain header" do
    expect(rendered).to have_selector('#h1.headline1', text: '> Создание новой статьи')
  end

end