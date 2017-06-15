class ProfilesController < ApplicationController
  before_action :owned_profile, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit

  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private
    def profile_params
      params.require(:user).permit(:avatar, :bio)
    end

    def set_user
      @user = User.find_by(user_name: params[:user_name])
    end

    def owned_profile
      @user = User.find_by(user_name: params[:user_name])
      unless @user == current_user
        flash[:success] = "That profile doesn't belong to you!"
        redirect_to root_path
      end
    end
end