require 'rails_helper'

RSpec.describe Comment, :type => :model do

  context "validates attribute" do
    it "has a valid factory" do
      FactoryGirl.create(:comment).should be_valid
    end
  end

  context "in-validate attribute" do
    it "is invalid without content" do
      FactoryGirl.build(:comment, content: nil).should_not be_valid
    end
  end

  context "association" do
    it "should be_longs user" do
      expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it "should be_longs post" do
      expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
    end
  end
end