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

      let!(:article) { stub_model(Article).as_null_object}
      let!(:params) do
        {
          title: "MyNewArticleTitle",
          content: "MyNewArticleContent",
          category_id: '1',
        }
      end

      before :each do
        Article.stub(:new).and_return(article)
      end

      it "sends new" do
        Article.should_receive(:new).with(params)
        post :create, article: params
      end

      context "When save message return true" do

        before :each do
          article.stub(:save).and_return(true)
        end

        it "redirects to show articles" do
          post :create, article: params
          expect(response).to redirect_to article_path
        end

        it "assigns a success flash message" do
          post :create, article: params
          expect(flash[:notice]).not_to be_nil
        end

      end

      context "When save message return false" do

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

end