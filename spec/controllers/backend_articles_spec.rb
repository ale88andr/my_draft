require 'spec_helper'

describe Backend::ArticlesController do

  describe "#create" do

    context "when user not login" do

      before { post :create }

      it "redirects to sign in page" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns error flash message" do
        expect(flash[:alert]).not_to be_nil
      end

    end# when user not login

    context "when user logged in" do

      login_admin

      let(:article) { mock_model(Article).as_null_object }
      let!(:params) do
        {
          "title" => "title",
          "content" => "content"
        }
      end

      before :each do
        Article.stub(:new).and_return(article)
      end

      it "sends new" do
        Article.should_receive(:new).with(params)
        post :create, article: params
      end

      context "when return true" do

        before :each do
          article.stub(:save).and_return(true)
          post :create, article: params
        end

        it "render show template" do
          expect(response).to redirect_to backend_article_path(article.last)
        end

        it "assigns a success flash message" do
          expect(flash[:notice]).not_to be_nil
        end

      end

      context "when return false" do

        before :each do
          article.stub(:save).and_return(false)
        end

        it "redirects to new article view" do
          post :create
          expect(response).to render_template :new
        end

        it "should flash error message exists" do
          post :create
          expect(flash[:error]).not_to be_nil
        end

      end

    end

  end# #create

  describe "#new" do

    context "when user logged in" do

      let!(:article) { mock_model('Article').as_new_record }
      before(:each) do
        login_as_admin
        Article.stub(:new).and_return(article)
      end

      it "render a 'new' template" do
        get :new
        expect(response).to render_template :new
      end

      it "assigns @article" do
        get :new
        expect(assigns[:article]).to eq(article)
      end

    end

    context "when user not login" do

      before { get :new }

      it "redirects to sign in page" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns error flash message" do
        expect(flash[:alert]).not_to be_nil
      end

    end

  end# #new

  describe "#index" do

    context "when user logged in" do

      let!(:articles) { stub_model(Article) }
      before :each do
        login_as_admin
        get :index
      end

      it "assigns @articles variable to the view" do
        expect(assigns[:articles]).to eq([])
      end

      it "render index template" do
        expect(response).to render_template :index
      end

    end

    context "when user not login" do

      before { get :index }

      it "redirects to sign in page" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns error flash message" do
        expect(flash[:alert]).not_to be_nil
      end

    end

  end# #index

  describe "#show" do

    context "when article exists" do

      let!(:article) { stub_model(Article) }
      @item = Article.create(id: 1001, title: "article", views: 0, category_id: 1, content: "content" )

      before :each do
        Article.stub(:find).and_return(article)
      end

      it "sends find message to model" do
        Article.should_receive(:find).with(@item.id)
        get :show, id: @item.id
      end
      it "assigns @article variable" do
        get :show, id: 1
        expect(assigns[:article]).to eq(article)
      end
      it "rendered show template" do
        get :show, id: 1
        expect(response).to render_template(:show)
      end

      context "#increment!" do

        before :each do
          @article = Article.create(id: 1, title: "article", views: 0, category_id: 1, content: "content" )
          Article.stub(:find).and_return(@article)
        end

        it "increments a views property" do
          expect{ get :show, id: 1 }.to change(@article.views)
        end

      end

    end

    context "on non existing article" do

      before :each do
        Article.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      end

      it "should redirects to articles index url" do
        expect(response).redirect_to articles_path
      end

      it "should have flash error message" do
        expect(flash[:error]).not_to be_nil
      end

    end

  end#GET 'show'

end