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
    respond_with_error (:error_auth_required) and return if user.blank? || !user.valid_password?(params[:password])

    # save new authentication token
    if user.authentication_token.blank?
      user.authentication_token = Devise.friendly_token
      user.save
    end

    # output the user with token
    respond_to do |format|
      format.json { render :json => user.as_json(User.private_options_plus(:authentication_token))}
      format.xml { render :xml => user.to_xml(User.private_options_plus(:authentication_token))}
      format.any { render :text => user.authentication_token}
    end
  end

  # generates a new api key
  def new_api_key
    current_user.set_new_api_key!
    redirect_to account_path
  end

  # edit public profile
  def edit_profile
    @user = current_user
  end

  # update public profile
  def update_profile
    @user = current_user # make our views "cleaner" and more consistent
    # update
    @user.update_attributes(user_params)
    redirect_to account_path
  end

  # public profile for a user
  def profile
    # set params and request.format correctly
    set_request_details!(params)

    @user = User.find_by_login(params[:id])

    # output error if user not found
    render :text => t(:user_not_found) and return if @user.nil?

    # set page title
    @title = @user.login || nil

    # if a json or xml request
    if request.format == :json || request.format == :xml
      # authenticate the user if the user is logged in (can be via token) or api key mathes the target user
      authenticated = (current_user == @user) || (User.find_by_api_key(get_apikey) == @user)
      # set options correctly
      options = authenticated ? User.private_options : User.public_options(@user)
    end

    # if html request
    if request.format == :html
      @channels = @user.channels.public_viewable.paginate :page => params[:page], :order => 'last_entry_id DESC'
    end

    respond_to do |format|
      format.html
      format.json { render :json => @user.as_json(options)}
      format.xml { render :xml => @user.to_xml(options)}
    end
  end

  # list all public channels for a user
  def list_channels
    @user = User.find_by_login(params[:id])

    # output error if user not found
    render :text => t(:user_not_found) and return if @user.nil?

    # if html request
    if request.format == :html
      @title = "Internet of Things - Public Channels for #{@user.login}"
      @channels = @user.channels.public_viewable.paginate :page => params[:page], :order => 'last_entry_id DESC'
    # if a json or xml request
    elsif request.format == :json || request.format == :xml
      # authenticate the user if api key matches the targer user
      authenticated = (User.find_by_api_key(get_apikey) == @user)
      # get all channels if authenticate, otherwise only public ones
      channels = authenticated ? @user.channels : @user.channels.public_viewable
      # set channels correctly
      @channels = { channels: channels.as_json(Channel.public_options)}
    end

    respond_to do |format|
      format.html
      format.json { render :json => @channels}
      format.xml { render :xml => @channels.to_xml(:root => 'response')}
    end
  end

  def show
    @menu = 'account'
    @user = @current_user
  end


end