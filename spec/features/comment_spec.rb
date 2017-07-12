require 'rails_helper'

RSpec.feature "Comment spec", :type => :feature do
  let(:user1) { FactoryGirl.create(:user) }
  let(:post1) { FactoryGirl.create(:post, user_id: user1.id) }
  let(:user2) { FactoryGirl.create(:user) }

  feature "Create comment" do
    scenario "comment own post without notification", js: true do
      login_with user1
      visit post_path post1
      fill_in 'comment[content]', with: "This is a comment"
      find('#comment_content_' + post1.id).native.send_keys(:return)
      expect(page).to have_content 'This is a comment'
      visit root_path
      expect(find('#dropdownMenu1')).to have_content '0'
    end

    scenario "comment other people post with notification", js: true do
      login_with user2
      visit post_path post1
      fill_in 'comment[content]', with: "This is a comment"
      find('#comment_content_' + post1.id).native.send_keys(:return)
      expect(page).to have_content 'This is a comment'
      logout
      login_with user1
      expect(find('#dropdownMenu1')).to have_content '1'
    end
  end

  feature "Destroy comment" do
    before do
      login_with user1
      visit post_path post1
    end

    scenario "confirm false will do not delete comment", js: true do
      fill_in 'comment[content]', with: "This is a comment"
      find('#comment_content_' + post1.id).native.send_keys(:return)
      page.has_selector?('#comment_' + post1.comments.first.id + ' > div > a:nth-child(3)')
      dismiss_confirm do
        find('#comment_' + post1.comments.first.id + ' > div > a:nth-child(3)').click
      end
      expect(page).to have_content 'This is a comment'
    end

    scenario "confirm true to delete comment", js: true do
      fill_in 'comment[content]', with: "This is a comment"
      find('#comment_content_' + post1.id).native.send_keys(:return)
      page.has_selector?('#comment_' + post1.comments.first.id + ' > div > a:nth-child(3)')
      accept_alert do
        find('#comment_' + post1.comments.first.id + ' > div > a:nth-child(3)').click
      end
      expect(page).not_to have_content 'This is a comment'
    end
  end
end
