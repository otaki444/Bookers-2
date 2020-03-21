class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update]
  def index
    @user = current_user
    @users = User.all
    @booknew = Book.new
  end
  def show
  	@user = User.find(params[:id])
    @booknew = Book.new
    @books = Book.all
  end
  def edit
  	@user = User.find(params[:id])
  end
  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
      @userfind = User.find(params[:id])
      render :edit
    end
  end

  private
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user.id)
    end
  end
  def user_params
  	params.require(:user).permit(:email,:name, :introduction, :profile_image)
  end
end