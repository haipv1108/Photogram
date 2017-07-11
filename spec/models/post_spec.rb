require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to be_mongoid_document }

  context "has factories" do
    it "be able to build" do
      expect(FactoryGirl.build(:post)).to be_valid
    end
    it "be able to create" do
      expect(FactoryGirl.create(:post)).to be_valid
    end
  end

  context "has field and relations, validations" do
    it { is_expected.to have_field(:caption).of_type(String) }
    it { is_expected.to have_fields(:created_at, :updated_at) }
    it { is_expected.to have_field(:user_id) }

    it { expect(Post.reflect_on_association(:user).macro).to eq :belongs_to }
    it { expect(Post.reflect_on_association(:comments).macro).to eq :has_many }

    it { is_expected.to validate_presence_of(:caption) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:user_id) }
    # it { is_expected.to validate_length_of(:caption).within(3..300) }
    it { expect(FactoryGirl.build(:post, caption: "aa")).not_to be_valid include("is too short (minimum is 3 characters)") }
    it { expect(FactoryGirl.build(:post, caption: "a" * 301)).not_to be_valid include("is too long (maximum is 300 characters)") }
  end

end
