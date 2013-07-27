require "spec_helper"

describe ArticlesController do
  describe "routing" do

    context "accessible routes" do
      it "routes to #index" do
        get("/articles").should route_to("articles#index")
      end

      it "routes to #show" do
        expect(get("/articles/1")).to route_to("articles#show", :id => "1")
      end

      it "routes to #index option : tooday" do
        expect(get("/articles/option/tooday")).to route_to(controller: 'articles', action: 'index', :option => "tooday")
      end

      it "routes to #index option : week" do
        expect(get("/articles/option/week")).to route_to(controller: 'articles', action: 'index', :option => "week")
      end

      it "routes to #index option : month" do
        expect(get("/articles/option/month")).to route_to(controller: 'articles', action: 'index', :option => "month")
      end
    end#accessible routes

    context "prohibited routes" do
      it "routes to #new not to be routable" do
        expect(get("/articles/new")).not_to be_routable
      end

      it "routes to #edit not to be routable" do
        expect(get("/articles/1/edit")).not_to be_routable
      end

      it "routes to #create not to be routable" do
        expect(post("/articles")).not_to be_routable
      end

      it "routes to #update not to be routable" do
        expect(put("/articles/1")).not_to be_routable
      end

      it "routes to #destroy not to be routable" do
        expect(delete("/articles/1")).not_to be_routable
      end
    end#prohibited routes

  end
end
