require 'spec_helper'

describe Backend::ArticlesController do

  describe "#create" do

    login_admin

    let(:articles) { mock_model(Article).as_null_object }
    let!(:params) do
      {
        "title" => "title",
        "content" => "content"
      }
    end

    before :each do
      Article.stub(:new).and_return(articles)
    end

    it "creates a new article" do
      Article.should_receive(:new).with(params)
      post :create, article: params
    end

  end

end