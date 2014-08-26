class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = find_user
    @biography = User.find_by(params[:biography_id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.avatar = nil
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :avatar, :biography)
  end

  def find_user
    User.find(params[:id])
  end
end

