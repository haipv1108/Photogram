require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    image = sample_image('test.jpg')
    @user = User.create(user_name: "Pham Haiaaa", email: "svsvsv@gmail.com", password: "password")
    @post = Post.new(caption: "Caption", image: image, user_id: @user.id)
  end

  test 'should have valid post' do
    assert @post.valid?
  end

  test 'invalid post without caption' do
    @post.caption = nil
    @post.valid?
    assert_not_nil @post.errors[:caption]
  end

  test 'invalid post with min length caption < 3' do
    @post.caption = "aa"
    @post.valid?
    assert_not_nil @post.errors[:caption]
  end

  test 'invalid post with max length caption > 300' do
    @post.caption = "a" * 301
    @post.valid?
    assert_not_nil @post.errors[:caption]
  end

  test 'invalid post without image' do
    @post.image = nil
    @post.valid?
    assert_not_nil @post.errors[:image]
  end

  test 'invalid post without user' do
    @post.user_id = nil
    assert_not @post.valid?
  end

end