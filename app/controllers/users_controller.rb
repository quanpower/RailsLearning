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

  # allow login via api
  def api_login
    # get the user by login or email
    user = User.find_by_login_or_email(params[:login])

    # exit if no user or invalid password
    respond_with_error(:error_auth_required) and return if user.blank? || !user.valid_password?(params[:password])

    # save new authentication token
    if user.authentication_token.blank?
      user.authentication_token = Devise.friendly_token
      user.save
    end

    # output the user with token
    respond_to do |format|
      format.json { render :json => user.as_json(User.private_options_plus(:authentication_token)) }
      format.xml { render :xml => user.to_xml(User.private_options_plus(:authentication_token)) }
      format.any { render :text => user.authentication_token }
    end
  end

  # generates a new api key
  def new_api_key
    current_user.set_new_api_key!
    redirect_to account_path
  end
  
end