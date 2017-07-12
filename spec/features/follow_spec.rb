require 'rails_helper'

RSpec.feature "Follower following", :type => :feature do
  let(:user1) {FactoryGirl.create(:user) }
  let(:user2) {FactoryGirl.create(:user) }

  before do
    login_with user1
    visit profile_path user2.user_name
  end

  scenario "follow user", js: true do
    find_link('FOLLOW', :visible => :all).visible?
    click_link 'FOLLOW'
    find_link('FOLLOWING', :visible => :all).visible?
  end
end
