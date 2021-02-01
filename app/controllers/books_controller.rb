class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if @book.save(book_params)
       flash[:notice] = "successfully"
       redirect_to book_path(@book)
    else
       render :index
    end
  end

  def show
   @book = Book.find(params[:id])
   @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def destroy
    @book= Book.find(params[:id])
    @book.destroy
    flash[:notice] = "successfully"
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    @books = Book.all
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render action: :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title,:profile_image_id, :body)
  end
end
