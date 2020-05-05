class UsersController < ApplicationController
  before_action :authenticate_user!
	before_action :baria_user, only: [:update, :edit]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @user = User.find(params[:id])#追記
  end

  def new
    @user = User.new #新規のユーザーを作成している
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @user = current_user

  end

  def edit
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.save
    flash[:notice] = "Welcome! You have signed up successfully."
  end


  def update
  	@user = User.find(params[:id]) 
    @user.update(user_params)
  if @user.save
  		redirect_to user_path(@user.id), notice: "You have updated user successfully."
  	else
  		render action: :edit
  	end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
    end
  end
end