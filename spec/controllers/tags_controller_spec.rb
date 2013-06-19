require 'spec_helper'

  describe TagsController do

    let!(:tag) { stub_model(Tag).as_new_record }

    describe "GET 'new'" do

      it "sends new message" do
        Tag.should_receive(:new)
        get :new
      end

      it "render 'new' template" do
        get :new
        expect(response).to render_template :new
      end
      
      it "assigns @tag instance variable to the 'new' template" do
        Tag.stub(:new).and_return(tag)
        get :new
        expect(assigns[:tag]).to eq(tag)
      end

    end

    describe "POST 'create'" do

      let!(:params) do
        { 
          "name" => "new_tag name"
        }
      end
      before :each do
        Tag.stub(:new).and_return(tag)
      end

      it "Sends data to Tag class" do
        Tag.should_receive(:new).with(params)
        post :create, tag: params
      end

      it "Sends 'save' method " do
        tag.should_receive(:save)
        post :create
      end

      context "When save method return true" do

        before :each do
          tag.stub(:save).and_return(true)
        end

        it "redirects to root url" do
          post :create, tag: params
          expect(response).to redirect_to tag
        end

        it "assigns a success flash message" do
          post :create, tag: params
          expect(flash[:notice]).not_to be_nil
        end

      end

      context "When save method return false" do

        before :each do
          tag.stub(:save).and_return(false)
          post :create, tag: params
        end
        
        it "Render new template" do
          expect(response).to render_template :new
        end
        
        it "Assigns reader variable to view" do
          expect(assigns[:tag]).to eq(tag)
        end
        
        it "Assigns error flash message" do
          expect(flash[:error]).not_to be_nil
        end
      
      end

    end

    describe "GET 'show'" do

      

    end

  end