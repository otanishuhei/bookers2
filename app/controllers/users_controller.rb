class UsersController < ApplicationController
  def index
    @users = User.all
    @new_book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books.order(created_at: :desc)
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
      return
    end

    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
      return
    end


    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
