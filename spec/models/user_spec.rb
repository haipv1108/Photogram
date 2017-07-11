require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }

  context "has a factories" do
    it "be able to build" do
      expect(FactoryGirl.build(:user)).to be_valid
    end
    it "be able to create" do
      expect(FactoryGirl.create(:user)).to be_valid
    end
  end

  context "has field and relations, validations" do
    it { is_expected.to have_field(:user_name).of_type(String) }
    it { is_expected.to have_field(:email).of_type(String) }

    it { expect(User.reflect_on_association(:posts).macro).to eq :has_many }
    it { expect(User.reflect_on_association(:comments).macro).to eq :has_many }
    it { expect(User.reflect_on_association(:notifications).macro).to eq :has_many }
    it { expect(User.reflect_on_association(:follows).macro).to eq :has_many }

    it { is_expected.to validate_presence_of(:user_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:user_name).case_insensitive }
    # it { is_expected.to validate_length_of(:user_name).within(4..16)}
    it { expect(FactoryGirl.build(:user, user_name: "aaa")).not_to be_valid include("is too short (minimum is 4 characters)") }
    it { expect(FactoryGirl.build(:user, user_name: "a" * 17)).not_to be_valid include("is too long (maximum is 16 characters)") }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  # context "validates attributes" do
  #   it "has a valid user" do
  #     expect(FactoryGirl.create(:user)).to be_valid
  #   end
  # end
  #
  # context "in-validates attribute" do
  #   it "is invalid without user name" do
  #     expect(FactoryGirl.build(:user, user_name: nil)).not_to be_valid
  #   end
  #   it "is invalid without email" do
  #     expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  #   end
  #   it "is invalid without password" do
  #     expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
  #   end
  #   it "is invalid with user name length min < 3" do
  #     expect(FactoryGirl.build(:user, user_name: "aa")).not_to be_valid
  #   end
  #   it "is invalid with user name length max > 16" do
  #     expect(FactoryGirl.build(:user, user_name: "a" * 17)).not_to be_valid
  #   end
  #   it "is invalid with user name not unique" do
  #     @user = FactoryGirl.create(:user)
  #     expect(FactoryGirl.build(:user, user_name: @user.user_name)).not_to be_valid
  #   end
  #   it "is invalid with email not unique" do
  #     @user = FactoryGirl.create(:user)
  #     expect(FactoryGirl.build(:user, email: @user.email)).not_to be_valid
  #   end
  # end
  #
  # context "associations" do
  #   it "should has_many: posts" do
  #     expect(User.reflect_on_association(:posts).macro).to eq :has_many
  #   end
  # end
end
