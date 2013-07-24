require 'spec_helper'

describe "articles/show" do
  
  before :each do
    user = FactoryGirl.create(:user)
    @ability = Ability.new(user)
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
    controller.stub(:current_user) { user }
  end

  it "renders single article attributes" do
    article = FactoryGirl.create(:article)
    assign(:article, article)
    render
    expect(view).to render_template(:partial => "comments/_comment_form")
    #expect(view).to render_template(:partial => "_comments")
    expect(rendered).to have_content article.title
    expect(rendered).to have_link(article.category.name, href: category_path(article.category.id))
    expect(rendered).to have_content article.content
    expect(rendered).to have_content article.user.username
    expect(rendered).to have_content article.views
  end

end#articles/show