require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do

  describe "GET #show" do
    render_views
    let(:user) {FactoryGirl.create(:user)}
    let(:other_user) {FactoryGirl.create(:user)}
    let(:own_post) { FactoryGirl.create(:post, user_id: user.id )}
    let(:post) { FactoryGirl.create(:post, user_id: other_user.id) }
    before :each do
      sign_in user
      session[:user_id] = user.id
      own_post
      post
    end

    context "own's profile" do
        it "get arrays of posts" do
          get :show, user_name: user.user_name
          assigns(:posts) == [own_post]
        end
        it "render the :show view" do
          get :show, user_name: user.user_name
          expect(response).to render_template :show
        end
        it "get edit profile button" do
          get :show, user_name: user.user_name
          expect(response.body).to include "Edit Profile"
        end
    end

    context "other's profile" do
      it "get arrays of posts" do
        get :show, user_name: other_user.user_name
        assigns(:posts) == [post]
      end
      it "render the :show view" do
        get :show, user_name: other_user.user_name
        expect(response).to render_template :show
      end
      it "no edit profile button" do
        get :show, user_name: other_user.user_name
        expect(response.body).not_to include "Edit Profile"
      end
    end
  end

  describe "GET edit" do
    render_views
    let(:user) {FactoryGirl.create(:user)}
    before :each do
      sign_in user
      session[:user_id] = user.id
    end

    it "assign @user" do
      get :edit, user_name: user.user_name
      expect(assigns(:user)).to eq user
    end
    it "render :edit view" do
      get :edit, user_name: user.user_name
      expect(response).to render_template :edit
    end
  end

  describe "PUT update" do
    render_views
    let(:user) {FactoryGirl.create(:user)}
    before :each do
      sign_in user
      session[:user_id] = user.id
    end
    context "validate attribute" do
      it "located the requested @user" do
        put :update, user_name: user.user_name, user: FactoryGirl.attributes_for(:user)
        assigns(:user) == user
      end
      it "changes user's attributes" do
        put :update, user_name: user.user_name,
            user: FactoryGirl.attributes_for(:user, user_name: "xxxxxxxxxx")
        user.reload
        user.user_name == "xxxxxxxxxx"
      end
      it "redirects to the updated user" do
        put :update, user_name: user.user_name,
            user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to profile_path(user.user_name)
      end
    end

    context "in-validate attribute" do
      it "locates the requests @post" do
        put :update, user_name: user.user_name, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq user
      end

      it "re-render the edit method" do
        put :update, user_name: user.user_name, user: FactoryGirl.attributes_for(:invalid_user)
        user.reload
        expect(response).to render_template :edit
      end
    end
  end
end
