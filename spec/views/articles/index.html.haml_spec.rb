require 'spec_helper'

describe "articles/index.html.haml" do

  include Devise::TestHelpers

  before :each do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end

  it "renders a list of articles" do

    articles, categories, tags = [], [], []
    categories << FactoryGirl.create(:category)
    tags << FactoryGirl.create(:tag)
    5.times { articles << FactoryGirl.create(:article)  }
    assign(:categories, categories)
    assign(:tags, tags)
    assign(:articles, Kaminari.paginate_array(articles).page(1))
    render
    expect(view).to render_template(:partial => "_article", :count => 5)
    expect(rendered).to have_link("Все", href: articles_path)
    expect(rendered).to have_link("За сутки", href: articles_path + '/option/tooday')
    expect(rendered).to have_link("За неделю", href: articles_path + '/option/week')
    expect(rendered).to have_link("За месяц", href: articles_path + '/option/month')
    expect(rendered).to have_link("Наиболее просматриваемые", href: articles_path + '/option/top_views')
    articles.each do |article|
      expect(rendered).to have_link(article.title)
      expect(rendered).to have_link("Читать полностью", href: article_path(article.id))
      expect(rendered).to have_link(article.views, href: article_path(article.id))
      expect(rendered).to have_link(article.category.name, href: category_path(article.category.id))
    end

  end

end#articles/index.html.haml