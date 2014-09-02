class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @title = "All users"
    @users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC')
  	@title = @user.name
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated."
      redirect_to @user
    else
      @title = "Edit user"
      render :edit
    end
  end

  def destroy
    @userToKill = User.find(params[:id])
    flash[:success] = "#{@userToKill.name} destroyed."
    @userToKill.destroy
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) 
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
