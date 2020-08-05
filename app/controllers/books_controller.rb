class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :check_current_user_book?, only: [:edit]

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def check_current_user_book?
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end

    # unless current_user.id == book.user_id
    #   redirect_to books_path
    # end
  end

end
