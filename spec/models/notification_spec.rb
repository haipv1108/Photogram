require 'rails_helper'

RSpec.describe Notification, :type => :model do

  context "validates attributes" do
    it "has a valid factory with type = like" do
      FactoryGirl.create(:notification).should be_valid
    end

    it "has a valid factory with type = comment" do
      FactoryGirl.create(:notification, notice_type: 'comment').should be_valid
    end
  end

  context "invalidate attribute" do

  end

  context "associations" do

  end
end