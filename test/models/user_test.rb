require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(user_name: 'HaiLeader', email: 'haileader@gmail.com', password: 'password')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without user_name' do
    @user.user_name = nil
    refute @user.valid?, 'user is valid without a username'
    assert_not_nil @user.errors[:user_name]
  end

  test 'invalid user name min lengh < 3' do
    @user.user_name = "aa"
    @user.valid?
    assert_not_nil @user.errors[:user_name]
  end

  test 'invalid user name max lengh > 16' do
    @user.user_name = "a" * 17
    @user.valid?
    assert_not_nil @user.errors[:user_name]
  end

  test 'should have unique user name' do
    @user1 = User.new(user_name: @user.user_name, email: 'email@gmail.com', password: 'password')
    @user1.valid?
    assert_not_nil @user1.errors[:user_name]
  end

  test 'invalid without email' do
    @user.email = nil
    assert_not @user.valid?
  end

  test 'should have unique email' do
    @user1 = User.new(user_name: 'username', email: @user.email, password: 'password')
    @user1.valid?
    assert_not_nil @user1.errors[:user_name]
  end

end
