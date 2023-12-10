class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to questions_path, success: 'サインアップが完了しました'
    else
      flash.now[:danger] = 'サインアップに失敗しました'
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def show
      @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), success: "更新に成功しました"
    else
      flash.now[:danger] = "更新に失敗しました"
      render :edit
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_description)
  end
end
