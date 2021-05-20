class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_post,only: [:edit]


  def index
    @books = Book.all
    @user = current_user
    @book=  Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
    if @book.save

      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      render "index"
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end

  def destroy
    @book  = Book.find(params[:id])
    @book.destroy
    redirect_to  books_path
  end

  def correct_post
        @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end


  protected

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
