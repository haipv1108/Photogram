require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  # describe "GET #index" do
  #   it "get an array of posts" do
  #     get :index
  #     assigns(:posts).should eq([@post])
  #   end
  #   it "render the :index view" do
  #     get :index
  #     response.should render_template :index
  #   end
  # end

  describe "GET #show" do
    render_views
    before :each do
      @post = FactoryGirl.create(:post)
      @user = FactoryGirl.create(:user)
      sign_in@user
      session[:user_id] = @user.id
    end

    it "as content owner" do
      sign_out @user
      @user = @post.user
      sign_in @user
      session[:user_id] = @user.id
      get :show, id: @post
      response.body.should have_content("Edit Post")
    end

    it "assign the request post to @post" do
      get :show, id: @post
      assigns(:post) == @post
    end
    it "render the :show view" do
      get :show, id: @post
      response.should render_template :show
    end
  end

  describe "GET #new" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
      session[:user_id] = @user.id
    end

    it "assign a new Post to @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
    it "render the :new view" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
      response.should render_template :new
    end
  end

  describe "POST #create" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
      session[:user_id] = @user.id
    end

    context "with valid attributes" do
      it "saves the new post in the database" do
        expect {
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change(Post, :count).by(1)
      end
      it "redirect to the root_path" do
        post :create, post: FactoryGirl.attributes_for(:post)
        response.should redirect_to Post.last
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
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    before :each do
      @post = FactoryGirl.create(:post)
      @user = @post.user
      sign_in(@user)
      session[:user_id] = @user.id
    end
    it "assign the request found @post" do
      get :edit, id: @post
      assigns(:post) == @post
    end

    it "render the :edit view" do
      get :edit, id: @post
      expect {
        assigns(:post).should eq @post
      }.should render_template :edit
    end
  end

  describe "PUT #update" do
    before :each do
      @post = FactoryGirl.create(:post)
      @user = @post.user
      sign_in(@user)
      session[:user_id] = @user.id
    end
    context "valid attributes" do
      it "located the requested @post" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post)
        assigns(:post).should eq(@post)
      end

      it "changes post's attributes" do
        put :update, id: @post,
            post: FactoryGirl.attributes_for(:post, caption: "beatiful")
        @post.reload
        @post.caption == "beatiful"
      end

      it "redirects to the updated post" do
        put :update, id: @post,
            post: FactoryGirl.attributes_for(:post)
        response.should redirect_to @post
      end
    end

    context "invalid attribute" do
      it "locates the requests @post" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
        assigns(:post).should eq(@post)
      end

      it "does not change @post's attribute" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post, caption: "beatiful")
        @post.reload
        @post.caption.should == "beatiful"
      end

      it "re-render the edit method" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :edit
      end
    end
  end

  describe "GET #like" do
    render_views
    before :each do
      @post = FactoryGirl.create(:post)
      @user = FactoryGirl.create(:user)
      sign_in@user
      session[:user_id] = @user.id
    end

    it "as post owner" do

    end
    it "post of other user"
  end

  describe "GET #unlike" do
    render_views
    before :each do
      @post = FactoryGirl.create(:post)
      @user = FactoryGirl.create(:user)
      sign_in@user
      session[:user_id] = @user.id
    end

    it "click unlike"
  end

  describe "GET #brower" do
    before :each do
      @post = FactoryGirl.create(:post)
      @user = @post.user
      sign_in(@user)
      session[:user_id] = @user.id
    end
    it "get an array of posts" do
      get :browse
      assigns(:posts) == [@post]
    end
    it "render the :index view" do
      get :browse
      response.should render_template :browse
    end
  end

end