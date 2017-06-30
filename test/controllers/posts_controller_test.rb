require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @user = User.create(user_name: "Pham Hai", email: "pham_haisv@gmail.com", password: "password")
    image = sample_image('test.jpg')
    @post = Post.new(caption: "Caption", image: image, user_id: @user.id)
  end

  # test "should get posts index" do
  #   get :index
  #   assert_response :success
  # end

  # test "should get new" do
  #   session[:user_id] = @user.id
  #   get :new
  #   assert_response :success
  # end
  #
  test "should get show" do
    session[:user_id] = @user.id
    get(:show, {'id' => @post.id})
    assert_response :success
  end
  #
  # test "should redirect create when user not logged in" do
  #   assert_no_difference 'Post.count' do
  #     post :create, post: {caption: "Caption"}
  #   end
  #   assert_redirected_to root_path
  # end
end