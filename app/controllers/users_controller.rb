class UsersController < ApplicationController
  include KeyUtilities
  skip_before_filter :verify_authenticity_token, :only => [:api_login]
  before_filter :require_user, :only => [:show, :edit, :update, :edit_profile]

  # delete account
  def destroy
    user = current_user
    user.delete
    flash[:notice] = t(:account_deleted)
    redirect_to root_path
  end