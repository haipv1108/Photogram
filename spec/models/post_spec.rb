require 'rails_helper'

RSpec.describe Post, :type => :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
end