class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
  end

  def show
     @books = current_user.books
     @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @book = Book.new
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User updated successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end
  
end
