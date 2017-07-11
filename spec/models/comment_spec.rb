require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it { is_expected.to be_mongoid_document }

  context "has factories" do
    it "be able to build" do
      expect(FactoryGirl.build(:comment)).to be_valid
    end
    it "be able to create" do
      expect(FactoryGirl.create(:comment)).to be_valid
    end
  end

  context "has field and relations, validations" do
    it { is_expected.to have_field(:content).of_type(String) }
    it { is_expected.to have_fields(:created_at, :updated_at) }
    it { is_expected.to have_field(:user_id) }
    it { is_expected.to have_field(:post_id) }

    it { expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to }
    it { expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to }

    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:post_id) }
  end

end
