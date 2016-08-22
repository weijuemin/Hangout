class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit]
  def index
    if logged_in
      redirect_to "/events"
    end
  end

  def login
    if logged_in
      redirect_to "/events"
    end
    user = User.find_by(email: params[:user][:email])
    if user
      if user.authenticate(params[:user][:password])
        session[:id] = user.id
        redirect_to "/events"
      else
        session[:id] = nil
        flash[:error] = ["Password incorrect"]
        redirect_to "/"
      end
    else
      flash[:error] = ["User not found!"]
      redirect_to "/"
    end
  end

  def register
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:id] = user.id
      redirect_to "/events"
    else
      flash[:error] = user.errors.full_messages
      redirect_to :action => 'register', :controller => 'users'
    end
  end

  def logout
    session.clear
    redirect_to "/"
  end

  def show
    @user = User.find(session[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update( user_params )
      redirect_to "/users/show"
    else
      flash[:error] = @user.errors.full_messages
      redirect_to "/users/edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
  end
end
