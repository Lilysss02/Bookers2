class UsersController < ApplicationController
  before_action :authenticate_user!

  # ユーザー一覧
  def index
    @users = User.all
    @user = current_user
    # 空のビューを作成
    @book = Book.new
  end

  # マイページ
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
    # マイページに自分の投稿のみを表示
    # @books = @user.books
  end

  # ユーザー編集ページ
  def edit
  	@user = User.find(params[:id])
  end

  # ユーザー情報更新
  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'User info was successfully update.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end