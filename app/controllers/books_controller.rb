class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
    # @book = @user.books
    # [book, book. book....].errors
    # book.errors
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
        flash[:notice] = "Book was successfully updated."
        redirect_to book_path(@book)
    else
        render action: :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end