require "spec_helper"

describe ArticlesController do
  describe "routing" do

    context "accessible routes" do

      it "route backend/articles to backend::articles controller" do
        expect(get("/backend/articles")).to route_to(controller: 'backend/articles', action: 'index')
      end

      it "route backend/articles/unpublished to backend::articles controller" do
        expect(get("/backend/articles/unpublished")).to route_to(controller: 'backend/articles', action: 'unpublished')
      end

      it "routes to #show action backend::articles controller with id" do
        expect(get("/backend/articles/1")).to route_to(controller: 'backend/articles', action: 'show', :id => '1')
      end

      it "routes to #new action backend::articles controller with id" do
        expect(get("/backend/articles/new")).to route_to(controller: 'backend/articles', action: 'new')
      end

      it "routes to #show backend::articles controller with id" do
        expect(put("/backend/articles/1")).to route_to(controller: 'backend/articles', action: 'update', :id => '1')
      end

      it "routes to #show backend::articles controller with id" do
        expect(post("/backend/articles")).to route_to(controller: 'backend/articles', action: 'create')
      end

      it "routes to #show backend::articles controller with id" do
        expect(get("/backend/articles/1/edit")).to route_to(controller: 'backend/articles', action: 'edit', id: '1')
      end

    end#accessible routes

    context "prohibited routes" do

      it "routes to #show with invalid id not to be routable" do
        ids = %w['unknown', 'u123', '123u']
        ids.each do |id|
          expect(get("/backend/articles/" + id)).not_to be_routable
        end
      end

    end#prohibited routes

  end
end