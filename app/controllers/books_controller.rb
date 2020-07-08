class BooksController < ApplicationController

before_action :authenticate_user!, only: [:new, :create, :index, :show, :edit, :update, :destroy]
before_action :correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
    @user = current_user

    
  end

  def show
    @bookd = current_user.books.build
    @book = Book.new
    @booker = Book.find(params[:id])
    @user = @booker.user


  end

  def new
  end

   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book)
       flash[:notice] = "Book was successfully created."
    else
        @books = Book.all
        render :"index"
     end
  end

  def edit
    @book = Book.find(params[:id])
   end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id)
    flash[:notice] = "Book was successfully update."
  else
     render 'edit'
      flash[:danger]= "Book"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    flash[:notice] = "Book was successfully destroyed"
  end

  

    private

    def book_params
      params.require(:book).permit(:title, :category, :body, :introduction)
    end

  def correct_user
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end

end