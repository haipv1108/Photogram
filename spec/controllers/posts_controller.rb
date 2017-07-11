require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe "GET #index" do
    login_user
    let(:post) { FactoryGirl.create(:post) }

    it "get an array of posts" do
      get :index
      assigns(:posts) == [post]
    end
    it "render the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    render_views
    let(:user) {FactoryGirl.create(:user)}
    let(:post) { FactoryGirl.create(:post) }
    let(:own_post) { FactoryGirl.create(:post, user_id: user.id )}
    before :each do
      sign_in user
      session[:user_id] = user.id
    end

    context "own show post" do
      it "as content owner" do
        get :show, id: own_post.id
        expect(response.body).to include("Edit Post")
      end
      it "assign the request post to @post" do
        get :show, id: own_post.id
        assigns(:post) == own_post
      end
      it "render the :show view" do
        get :show, id: own_post.id
        expect(response).to render_template :show
      end
    end

    context "other user's post" do
      it "content of other user" do
        get :show, id: post.id
        expect(response.body).not_to include("Edit Post")
      end
      it "assign the request post to @post" do
        get :show, id: post.id
        assigns(:post) == post
      end
      it "render the :show view" do
        get :show, id: post.id
        expect(response).to render_template :show
      end
    end
  end

  describe "GET #new" do
    login_user

    it "assign a new Post to @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
    it "render the :new view" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    login_user

    context "with valid attributes" do
      it "saves the new post in the database" do
        expect {
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change(Post, :count).by(1)
      end
      it "redirect to the root_path" do
        post :create, post: FactoryGirl.attributes_for(:post)
        expect(response).to redirect_to Post.last
      end
    end

    context "with invalid attributes" do
      it "does not save the post in database" do
        expect {
          post :create, post: FactoryGirl.attributes_for(:invalid_post)
        }.to_not change(Post, :count)
      end
      it "re-render the :new template" do
        post :create, post: FactoryGirl.attributes_for(:invalid_post)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    let(:user) {FactoryGirl.create(:user)}
    let(:post) { FactoryGirl.create(:post) }
    let(:own_post) { FactoryGirl.create(:post, user_id: user.id )}
    before :each do
      sign_in user
      session[:user_id] = user.id
    end

    context "the own's post" do
      it "assign @post" do
        get :edit, id: own_post.id
        assigns(:post) == own_post
      end
      it "render page edit" do
        get :edit, id: own_post.id
        expect(response).to render_template :edit
      end
    end

    context "other's post" do
      it "show error not assign @post" do
        get :edit, id: post.id
        expect(response).to redirect_to root_path include "That post doesn't belong to you!"
      end
    end
  end

  describe "PUT #update" do
    let(:user) {FactoryGirl.create(:user)}
    let(:post) { FactoryGirl.create(:post, user_id: user.id )}
    before :each do
      sign_in user
      session[:user_id] = user.id
    end

    context "validates attributes" do
      it "located the requested @post" do
        put :update, id: post, post: FactoryGirl.attributes_for(:post)
        assigns(:post) == post
      end
      it "changes post's attributes" do
        put :update, id: post,
            post: FactoryGirl.attributes_for(:post, caption: "beatiful")
        post.reload
        post.caption == "beatiful"
      end
      it "redirects to the updated post" do
        put :update, id: post,
            post: FactoryGirl.attributes_for(:post)
        response.should redirect_to post
      end
    end

    context "invalid attribute" do
      it "locates the requests @post" do
        put :update, id: post, post: FactoryGirl.attributes_for(:invalid_post)
        assigns(:post) == post
      end
      it "re-render the edit method" do
        put :update, id: post, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :edit
      end
    end
  end
end
