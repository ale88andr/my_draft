require 'spec_helper'

describe ArticlesController do

  def valid_attributes
    { 
      "id" => 1001,
      "title" => "MyNewArticleTitle",
      "content" => "MyNewArticleContent",
      "category_id" => 1,
      "user_id" => 1,
      "created_at" => '2013-05-21 11:58:56.820779',
      "updated_at" => '2013-05-21 11:58:56.820779'
    }
  end

  describe "GET index" do

    let!(:articles) {Article.all}

    it "assigns @articles variable to the view" do
      get :index
      expect(assigns[:articles]).to eq(articles)
    end
    it "render index template" do
      get :index
      expect(response).to render_template :index
    end

  end

  describe "GET new" do

    let!(:article) { stub_model(Article) }
    before :each do
      Article.stub(:new).and_return(article)
    end

    it "sends new article to Article class" do
      #pending()
      Article.stub_chain(:current_user, :articles).and_return(article)
      Article.stub(:new).and_return(article)
      Article.current_user.articles.should_receive(:new).with(valid_attributes)
    end

    it "sends save message to a Reader model" do
      article.should_receive(:save)
      post :create
    end

  end

end