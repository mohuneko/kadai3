class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :corrent_user, only: [:edit, :update]

  def show
    book = Book.new
  	@book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new #投稿フォーム
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @user = current_user
  end

  def new
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
      flash[:message] = "successfully"
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      @user = current_user
  		@books = Book.all
  		render action: :index
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy #削除
    redirect_to books_path #booksへリダイレクト
  end

  def corrent_user
    @book = Book.find(params[:id])
   if @book.user != current_user
    redirect_to books_path
  end
end


  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
      flash[:message] = "successfully"
  		redirect_to book_path
      # notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  def corrent_user
    @book = Book.find(params[:id])
   if @book.user != current_user
    redirect_to books_path
  end
end

  private

  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end

end
