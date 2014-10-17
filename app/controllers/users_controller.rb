class UsersController < ApplicationController
  before_filter :authenticate_user!
  # before_action :authenticate_user!
  # user_signed_in?
  # current_user
  # user_session

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

end
