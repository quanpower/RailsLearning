class ChannelsController < ApplicationController
  include ChannelsHelper, ApiKeys

  before_filter :authenticate_via_api_key!, :only => [:index]
  before_filter :require_user, :except => [:realtime, :realtime_update, :show, :post_data, :social_show, :social_feed, :public]
  before_filter :set_channels_menu
  layout 'application', :except => [:social_show, :social_feed]
  protect_from_forgery :except => [:realtime, :realtime_update, :post_data, :create, :destroy, :clear]

  require 'csv'
  require 'will_paginate/array'

  # get list of all realtime channels
  def realtime
    # error if no key
    respond_with_error(:error_auth_required) and return if params[:realtime_key] != REALTIME_DAEMON_KEY
    channels = Channel.where("realtime_io_serial_number IS NOT NULL")
    render :json => channels.to_json(:root => false, :only => [:id, :realtime_io_serial_number])
  end

  # view list of watched channels
  def watched
    @channels = current_user.watched_channels
  end

  # user watches a channel
  def watch
    @watching = Watching.find_by_user_id_and_channel_id(current_user.id, params[:id])

    # add watching
    if params[:flag] == 'true'
      @watching = Watching.new(:user_id => current_user.id, :channel_id => params[:id]) if @watching.nil?
      @watching.save
    else
      # delete watching
      @watching.delete if !@watching.nil?
    end

    render :text => '1'
  end
  

end
