class UsersController < ApplicationController
    before_action :authenticate_user!
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
      @user = User.find(params[:id])
      render :edit
  end

  private
  def user_params
  	params.require(:user).permit(:email,:name, :introduction, :profile_image)
  end
end