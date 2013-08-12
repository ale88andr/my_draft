require 'spec_helper'

describe Backend::ArticlesController do

  share_examples_for "guest user" do
    it "redirects to sign in page" do
      expect(response).to redirect_to new_user_session_path
    end

    it "assigns error flash message" do
      expect(flash[:alert]).not_to be_nil
    end
  end

  describe "#create" do

    context "when user not login" do
      before { post :create }
      it_should_behave_like "guest user"
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

      login_admin

      let!(:article) { mock_model('Article').as_new_record }
      before(:each) do
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
      it_should_behave_like "guest user"
    end

  end# #new

  describe "#index" do

    context "when user logged in" do

      login_admin

      let!(:articles) { stub_model(Article) }
      before :each do
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
      it_should_behave_like "guest user"
    end

  end# #index

  describe "#show" do

    context "when article exists" do

      login_admin

      let!(:item) { FactoryGirl.create(:article) }
      let!(:article) { stub_model(Article).as_null_object }

      before :each do
        Article.stub(:find).and_return(article)
      end

      it "sends find" do
        Article.should_receive(:find).with(item.id.to_s)
        get :show, id: item.id
      end
      it "assigns @article variable" do
        get :show, id: 1
        expect(assigns[:article]).to eq(article)
      end
      it "rendered show template" do
        get :show, id: 1
        expect(response).to render_template(:show)
      end

    end

    context "on non existing article" do

      before :each do
        Article.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      end

      xit "render error page" do
        expect(response).to render_template "errors/route_error_404.html"
      end

      xit "404 error message" do
        expect(response).to have_content "404"
      end

    end

    context "when user not login" do
      before { get :show, id: 1 }
      it_should_behave_like "guest user"
    end

  end# #show

  describe "#update" do

    context "when user login" do

      login_admin

      let!(:item) { FactoryGirl.create(:article) }
      let!(:article) { stub_model(Article).as_null_object }
      params = {
        "title" => "another article title",
        "content" => "another article content",
        "category_id" => "1"
      }

      before do
        Article.stub(:find).and_return(article)
      end

      it "sends find" do
        Article.should_receive(:find).with(item.id.to_s)
        put :update, id: item.id, article: params
      end

      it "assigns @article variable" do
        put :update, id: item.id, article: params
        expect(assigns[:article]).to eq(article)
      end

      context "when update_attributes return true" do

        before do
          Article.stub(:update_attributes).and_return(true)
          put :update, id: item.id, article: params
        end

        xit "redirect to show" do
          expect(response).to redirect_to backend_article_path(item.id)
        end

        it "with success message" do
          expect(flash[:notice]).not_to be_nil
        end

      end

      context "when update_attributes return false" do

        invalid_params = {
          "title" => "",
          "content" => "",
          "category_id" => ""
        }

        before do
          Article.stub(:update_attributes).and_return(false)
          put :update, id: item.id, article: invalid_params
        end

        it "redirect to edit" do
          expect(response).to render_template(:edit)
        end

        it "with error message" do
          expect(flash[:error]).not_to be_nil
        end

      end

    end

    context "when user not login" do
      before { put :update, id: 1 }
      it_should_behave_like "guest user"
    end

  end# #update

  describe "#edit" do

    context "when user login" do

      login_admin

      let!(:item) { FactoryGirl.create(:article) }
      let!(:article) { mock_model(Article).as_null_object }

      before do
        Article.stub(:find).and_return(article)
      end

      it "sends find" do
        Article.should_receive(:find).with(item.id.to_s)
        get :edit, id: item.id
      end

      it "render edit template" do
        get :edit, id: item.id
        expect(response).to render_template(:edit)
      end

      it "assigns @article" do
        get :edit, id: item.id
        expect(assigns[:article]).to eq(article)
      end

    end

    context "when user not login" do
      before { get :edit, id: 1 }
      it_should_behave_like "guest user"
    end

  end

end