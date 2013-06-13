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

    it "sends new article to Article class" do
      params = {
        "title" => "NewArticleTitle",
        "content" => "NewArticleContent"
      }
      Article.should_receive(:new).with(params)
    end

  end

end