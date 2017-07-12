require 'rails_helper'

RSpec.feature "Create new Post", :type => :feature do
  let(:user) { FactoryGirl.create(:user) }
  before do
    login_with user
    visit new_post_path
  end

  scenario "valid input" do
    attach_file 'post[image]', 'app/assets/images/default-image.jpg'
    fill_in 'post[caption]', with: 'This is beatiful'
    click_button 'Create Post'
    expect(current_path).to eq post_path(Post.last)
    expect(page).to have_content('Your post has been created!')
  end

  scenario "invalid attach_file blank" do
    fill_in 'post[caption]', with: 'This is beatiful'
    click_button 'Create Post'
    expect(current_path).to eq posts_path
    expect(find('div.post_image.field_with_errors')).to have_content("can't be blank")
  end

  scenario "invalid caption blank" do
    attach_file 'post[image]', 'app/assets/images/default-image.jpg'
    click_button 'Create Post'
    expect(current_path).to eq posts_path
    expect(find('div.post_caption.field_with_errors')).to have_content("can't be blank")
  end

  scenario "invalid caption min lengh" do
    attach_file 'post[image]', 'app/assets/images/default-image.jpg'
    fill_in 'post[caption]', with: 'aa'
    click_button 'Create Post'
    expect(current_path).to eq posts_path
    expect(find('div.post_caption.field_with_errors')).to have_content("is too short (minimum is 3 characters)")
  end

  scenario "invalid caption max lengh" do
    attach_file 'post[image]', 'app/assets/images/default-image.jpg'
    fill_in 'post[caption]', with: 'a'*301
    click_button 'Create Post'
    expect(current_path).to eq posts_path
    expect(find('div.post_caption.field_with_errors')).to have_content("is too long (maximum is 300 characters)")
  end

  scenario "login require to create post" do
    logout
    visit new_post_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
