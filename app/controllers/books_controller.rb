class BooksController < ApplicationController
  def index
    @books = Book.includes(:user).order(created_at: :desc)
    @user = current_user
    @new_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @new_book = @book
      @books = Book.includes(:user).order(created_at: :desc)
      @user = current_user
      render :index
    end
  end

  def edit
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
      return
    end

    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
      return
    end

    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
