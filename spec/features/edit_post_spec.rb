require 'rails_helper'

RSpec.feature "Edit post", :type => :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user_id: user.id ) }
  let(:not_own_post) { FactoryGirl.create(:post) }

  before do
    login_with user
  end

  scenario "can't edit other people post" do
    visit edit_post_path not_own_post
    expect(current_path).to eq root_path
    expect(page).to have_content "That post doesn't belong to you!"
  end

  scenario "valid input" do
    visit edit_post_path post
    fill_in 'post[caption]', with: "This is beatiful"
    click_button 'Update Post'
    expect(current_path).to eq post_path post
    expect(page).to have_content "This is beatiful"
  end

  scenario "invalid input" do
    visit edit_post_path post
    fill_in 'post[caption]', with: "aa"
    click_button 'Update Post'
    expect(current_path).to eq post_path post
    expect(page).to have_content "is too short (minimum is 3 characters)"
  end
end
