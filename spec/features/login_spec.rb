require 'rails_helper'

RSpec.feature "Login", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  describe 'initial login' do
    context 'normal user' do
      before do
        login_with user
      end

      it 'should login successful to home page' do
        expect(current_path).to eq root_path
      end
    end

    context 'user does not exist' do
      let(:invalid_user) { User.new(email: 'invalid_email@gmail.com', password: 'invalid_password') }
      before do
        login_with invalid_user
      end

      it 'should login failed to login page' do
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'logout' do
    before do
      login_with user
    end

    it 'should logout successful to login page' do
      logout
      expect(current_path).to eq new_user_session_path
    end
  end
end
