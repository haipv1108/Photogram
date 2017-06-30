require 'rails_helper'

RSpec.describe User, :type => :model do
  context "validates attributes" do
    it "has a valid user" do
      FactoryGirl.create(:user).should be_valid
    end
  end

  context "in-validates attribute" do
    it "is invalid without user name" do
      FactoryGirl.build(:user, user_name: nil).should_not be_valid
    end
    it "is invalid without email" do
      FactoryGirl.build(:user, email: nil).should_not be_valid
    end
    it "is invalid without password" do
      FactoryGirl.build(:user, password: nil).should_not be_valid
    end
    it "is invalid with user name length min < 3" do
      FactoryGirl.build(:user, user_name: "aa").should_not be_valid
    end
    it "is invalid with user name length max > 16" do
      FactoryGirl.build(:user, user_name: "a" * 17).should_not be_valid
    end
    it "is invalid with user name not unique" do
      @user = FactoryGirl.create(:user)
      @user1 = FactoryGirl.build(:user, user_name: @user.user_name).should_not be_valid
    end
    it "is invalid with email not unique" do
      @user = FactoryGirl.create(:user)
      @user1 = FactoryGirl.build(:user, email: @user.email).should_not be_valid
    end
  end

  context "associations" do
    it "should has_many: posts" do
      expect(User.reflect_on_association(:posts).macro).to eq :has_many
    end
  end
end