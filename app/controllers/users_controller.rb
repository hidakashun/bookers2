class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update,]#他人のユーザ情報編集画面に遷移できないようにしてる（カリキュラムほかのユーザーからのアクセスを制限しよう）
  def index
    @users = User.all
    @user = current_user

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

  end

  def edit


    @user = User.find(params[:id])

  end

  def update


    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def is_matching_login_user#他人のユーザ情報編集画面に遷移できないようにしてる（カリキュラムほかのユーザーからのアクセスを制限しよう）
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to current_user#ここではじいたときに行先を決める(現在ログインしているユーザーのデータ)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
