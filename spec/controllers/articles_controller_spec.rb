require 'spec_helper'

describe ArticlesController do

  before :each do

  end

  describe "GET index" do

    let!(:articles) { stub_model(Article) }

    it "assigns @articles variable to the view" do
      get :index
      expect(assigns[:articles]).to eq([])
    end

    it "render index template" do
      get :index
      expect(response).to render_template :index
    end

  end#GET index

  describe "POST 'create'" do

    let!(:article) { stub_model(Article).as_new_record }
    let!(:params) do
      {
        "title" => "MyNewArticleTitle",
        "content" => "MyNewArticleContent",
        "category_id" => '1',
      }
    end

    before :each do
      Article.stub(:new).and_return(article)
    end

    it "sends new article to Article class" do
      Article.should_receive(:new).with(params)
      post :create, article: params
    end

    context "When save message return true" do
        before :each do
          article.stub(:save).and_return(true)
        end
        it "redirects to root url" do
          post :create, article: params
          expect(response).to redirect_to root_url
        end
        it "assigns a success flash message" do
          post :create, article: params
          expect(flash[:notice]).not_to be_nil
        end
      end

  end#POST 'create'

end