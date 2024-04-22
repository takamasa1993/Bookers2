class BooksController < ApplicationController
  
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = @book.errors.full_messages.join(", ")
      render :new
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to user_book_path(current_user, @book)
    else
    flash.now[:alert] = @book.errors.full_messages.join(", ")
    render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to books_path
    else
    flash[:alert] = "Failed to delete the book."
    redirect_back(fallback_location: root_path)
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
    @book = Book.new
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
