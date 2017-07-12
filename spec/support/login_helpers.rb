module LoginHelpers
  def login_with(user, remember: false)
    visit new_user_session_path
    fill_in "user[email]",        with: user.email
    fill_in "user[password]",     with: user.password
    check 'user_remember_me' if remember
    click_button "Log in"
    Thread.current[:current_user] = user
  end

  def logout
    visit root_path
    click_link 'Logout'
    # visit destroy_user_session_path
  end
end
