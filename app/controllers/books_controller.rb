class BooksController < ApplicationController
  
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      flash.now[:alert] = @book.errors.full_messages.join(", ")
      render :index
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if current_user == @book.user
      if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book)
      else
      flash.now[:alert] = @book.errors.full_messages.join(", ")
      render :edit
      end
    else
      flash[:alert] = "You don't have permission to perform this action."
      redirect_to root_path
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    if current_user == @book.user
      @book.destroy
      flash[:success] = "Book was successfully deleted."
      redirect_to books_path
    else
      flash[:alert] = "Failed to delete the book."
      redirect_back(fallback_location: root_path)
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
  end
  
  def edit
    @book = Book.find(params[:id])
    unless current_user.id == @book.user_id
      redirect_to book_path(@book)
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
