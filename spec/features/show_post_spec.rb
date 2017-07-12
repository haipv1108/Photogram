require 'rails_helper'

RSpec.feature "Show post", :type => :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user_id: user.id) }
  let(:not_own_post) { FactoryGirl.create(:post) }

  before do
    login_with user
  end

  scenario "show own post" do
    visit post_path post
    find_link('Edit Post', :visible => :all).visible?
    click_link 'Edit Post'
    expect(current_path).to eq edit_post_path(post)
  end

  scenario "show other people post" do
    visit post_path not_own_post
    expect(page).not_to have_content 'Edit Post'
  end
end
