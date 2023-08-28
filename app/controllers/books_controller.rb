class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new#いらない？
    @book = Book.neww#いらない？
  end#いらない？

  def create

    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user = current_user
    render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)#投稿でユーザー情報の表示をする
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

 def is_matching_login_user
   book =Book.find(params[:id])
  unless book.user.id == current_user.id
    redirect_to books_path
  end
 end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
