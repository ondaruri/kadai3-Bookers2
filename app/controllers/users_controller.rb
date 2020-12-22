class UsersController < ApplicationController
  before_action :authenticate_user!


  def new
  end

  def edit
    @user = current_user
    if params[:id].to_i == current_user.id
      render action: :edit
    else
     redirect_to user_path(@user)
    end
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "Book was successfully created."
       redirect_to books_path
    else
      @books = Book.all
      render :show
    end
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "User was successfully updated."
    redirect_to user_path(@user.id)
    else
    render action: :edit
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end