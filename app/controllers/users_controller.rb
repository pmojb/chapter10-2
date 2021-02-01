class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books =@user.books
    @post_images = @user.profile_image
  end


  def edit
    @user = User.find(params[:id])
    if @user !=current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @users = User.all
    if @user.update(user_params)
       flash[:notice] = "successfully"
       redirect_to user_path(@user)
    else
       render :edit
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
