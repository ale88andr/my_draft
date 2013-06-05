require 'spec_helper'

describe "articles/new" do
  before(:each) do
    assign(:article, stub_model(Article,
      :title => "MyString",
      :content => "MyText",
      :user => nil,
      :category => nil,
      :published => false
    ).as_new_record)
  end

  it "renders new article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articles_path, :method => "post" do
      assert_select "input#article_title", :name => "article[title]"
      assert_select "textarea#article_content", :name => "article[content]"
      assert_select "input#article_user", :name => "article[user]"
      assert_select "input#article_category", :name => "article[category]"
      assert_select "input#article_published", :name => "article[published]"
    end
  end
end