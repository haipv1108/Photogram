require 'rails_helper'

RSpec.describe Post, :type => :model do

  context "validates attributes" do
    it "has a valid factory" do
      FactoryGirl.create(:post).should be_valid
    end
  end

  context "in-validates attribute" do
    it "is invalid without a caption" do
      FactoryGirl.build(:post, caption: nil).should_not be_valid
    end
    it "is invalid without a image" do
      FactoryGirl.build(:post, image: nil).should_not be_valid
    end
    it "is invalid without a user id" do
      FactoryGirl.build(:post, user_id: nil).should_not be_valid
    end
    it "is invalid with caption length min < 3" do
      FactoryGirl.build(:post, caption: "aa").should_not be_valid
    end
    it "is invalid with caption length max > 300" do
      FactoryGirl.build(:post, caption: "a" * 301).should_not be_valid
    end
  end

  context "associations" do
    it "should be_longs user" do
      expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      expect(Post.column_names).to include 'user_id'
    end
  end
end