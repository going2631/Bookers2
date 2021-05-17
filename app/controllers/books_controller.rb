class BooksController < ApplicationController
  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to books_path
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user_id
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end

  def destroy
    @book  = Book.find(params[:id])
    @book.destroy
    redirect_to  books_path
  end

  protected

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
