require 'spec_helper'

describe Backend::UsersController do

  login_admin

  describe "#index" do
    it "populates an array of users" do
      # user = FactoryGirl.create(:valid_user)
      user = User.all
      get :index
      expect(assigns(:users)).to eq(user)
    end
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "#show" do
    before :each do
      @user = FactoryGirl.create(:valid_user)
      get :show, id: @user
    end

    it "assigns the requested user to @user" do
      expect(assigns[:user]).to eq(@user)
    end
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "#edit" do
    before :each do
      @user = FactoryGirl.create(:valid_user)
      get :edit, id: @user, user: @user
    end

    it "assigns the requested user to @user" do
      expect(assigns[:user]).to eq(@user)
    end
    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "#update" do

    before :each do
      @user = FactoryGirl.create(:valid_user)
    end

    context "when return true" do

      it "changes @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:valid_user, username: "example_user", email: "another@email.com" )
        @user.reload
        @user.username.should eq("example_user")
        @user.email.should eq("another@email.com")
      end

      context "redirects options" do

        before :each do
          put :update, id: @user, user: FactoryGirl.attributes_for(:valid_user)
        end

        it "requested @user" do
          expect(assigns[:user]).to eq @user
        end

        it "redirects to the updated user" do
          expect(response).to redirect_to backend_users_path
        end

        it "flash notice message" do
          expect(flash[:notice]).not_to be_nil
        end
      end
    end

    context "when return false" do

      it "does not change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user, email: "nil@user.com")
        @user.reload
        @user.username.should_not be_nil
        @user.email.should_not eq("nil@user.com")
      end

      context "redirects options" do

        before :each do
          put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        end

        it "re-render edit form" do
          expect(response).to render_template :edit
        end

        it "locates the requested @contact" do
          expect(assigns(:user)).to eq(@user)
        end

        it "flash error message" do
          expect(flash[:error]).not_to be_nil
        end
      end
    end
  end

  describe "#destroy" do

    before :each do
      @user = FactoryGirl.create(:valid_user)
    end

    it "delete the user" do
      expect{ delete :destroy, id: @user }.to change(User,:count).by(-1)
    end

    it "redirects to index" do
      delete :destroy, id: @user
      expect(response).to redirect_to backend_users_path
    end
  end

end
