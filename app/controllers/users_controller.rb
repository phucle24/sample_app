class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    @microposts = @user.microposts.paginate(page: params[:page])
    return if @user

    flash[:alert] = t ".not_found"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      flash[:alert] = t ".create_fail"
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update(user_params)
      flash[:success] = t ".update_success"
      redirect_to user_path @user
    else
      render :edit
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmations
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".alert_login"
    redirect_to login_url
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
