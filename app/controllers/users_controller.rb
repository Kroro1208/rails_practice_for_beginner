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
    if params[:id] != 'new'
      @user = User.find(params[:id])
    else
      redirect_to new_user_path
    end
  end

  def update
    @user = User.find(params[:id])
    # パスワードが6桁より少ない場合のエラー処理
    if user_params[:password].present? && user_params[:password].length < 6
      Rails.logger.error(@user.errors.full_messages)
      flash.now[:danger] = 'パスワードは6桁で設定してね！'
      render :edit
    else
      # パスワードが6桁以上の場合、通常の更新処理を実行
      if @user.update(user_params)
        redirect_to root_path, success: 'ユーザー情報を更新しました'
      else
        # Rails.logger.error(@user.errors.full_messages)
        flash.now[:danger] = '更新に失敗しました'
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :profile_description, :password_confirmation)
  end
end
