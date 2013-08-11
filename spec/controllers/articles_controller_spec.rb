require 'spec_helper'

describe ArticlesController do

  describe "when user not login" do

    describe ".create" do

      it "redirects to root url" do
        post :create
        expect(response).to redirect_to root_path
      end

      it "assigns error flash message" do
        post :create
        expect(flash[:error]).not_to be_nil
      end

    end#POST 'create'

  end

  describe "when user logged in" do

    login_admin

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

    end#POST 'create'

    describe "GET 'new'" do

      let!(:article) { mock_model('Article').as_new_record }
      before(:each) do
        Article.stub(:new).and_return(article)
      end

      it "rendered a 'new' template" do
        get :new
        expect(response).to render_template :new
      end

      it "assigns @article variable into a new view" do
        get :new
        expect(assigns[:article]).to eq(article)
      end

    end

    describe "GET 'show'" do

      context "on existing article" do

        let!(:article) { stub_model(Article) }

        before :each do
          Article.stub(:find).and_return(Article)
          Article.stub(:increment!).and_return(true)
        end

        it "sends find message to model" do
          Article.should_receive(:find).with('1')
          get :show, id: 1
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

    describe "PUT 'update'" do

      params = {
        "title" => "article1",
        "content" => "article1 content",
        "category_id" => "1"
      }

      let!(:article) { stub_model(Article, id: 1) }

      before do
        Article.stub(:find).and_return(article)
      end

      it "send find message to a model" do
        Article.should_receive(:find).with('1')
        put :update, id: article.id, article: params
      end


    end#PUT 'update'

  end

end