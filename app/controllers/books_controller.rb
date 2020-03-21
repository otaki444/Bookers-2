class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "You have created book successfully."
			redirect_to book_path(@book.id)
		else
			@booknew = @book
			@books = Book.all
			@user = current_user
			render :index
		end
	end
	def index
		@booknew = Book.new
		@books = Book.all
		@user = current_user
	end
	def show
		@booknew = Book.new
		@book = Book.find(params[:id])
		@books = Book.all
		@user = current_user
	end
	def edit
		@book = Book.find(params[:id])
	end
	def update
		@book = Book.find(params[:id])
  		if @book.update(book_params)
  			flash[:notice] = "You have updated book successfully."
  			redirect_to book_path(@book.id)
  		else
  			@bookfind = Book.find(params[:id])
    		render :edit
  		end
	end
	def destroy
		book = Book.find(params[:id])
		book.destroy
    	redirect_to books_path
	end
	private
	def correct_user
		book = Book.find(params[:id])
    	if current_user.id != book.user.id
      		redirect_to books_path
      	end
    end
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
