require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :title => "MyString",
      :content => "MyText",
      :user => nil,
      :category => nil,
      :published => false
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articles_path(@article), :method => "post" do
      assert_select "input#article_title", :name => "article[title]"
      assert_select "textarea#article_content", :name => "article[content]"
      assert_select "input#article_user", :name => "article[user]"
      assert_select "input#article_category", :name => "article[category]"
      assert_select "input#article_published", :name => "article[published]"
    end
  end
end
