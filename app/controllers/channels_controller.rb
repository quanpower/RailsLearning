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

  # list public channels
  def public
    # error if page 0
    respond_with_error(:error_resource_not_found) and return if params[:page] == '0'

    @domain = domain
    # default blank response
    @channels = Channel.where(:id => 0).paginate :page => params[:page]

    # get channels by ids
    if params[:channel_ids].present?
      @header = "Channels"
      @channels = Channel.public_viewable.by_array(params[:channel_ids]).order('ranking desc, updateed_at DESC').paginate :page => params[:page]
    # get channels that match a user
    elsif params[:username].present?
      @header = "#{t(:user).capitalize}: #{params[:username]}"
      searched_user = User.find_by_login(params[:username])
      @channels = searched_user.channels.public_viewable.active.order('ranking desc, updated_at DESC').paginate :page => params[:page] if searched_user.present?
    # get channels that match a tag
    elsif params[:tag].present?
      @header = "#{"tag".capitalize}: #{params[:tag]}"
      @channels = Channel.public_viewable.active.order('ranking desc, updated_at DESC').with_tag(params[:tag]).paginate :page => params[:page]
    # get channels by location
    elsif params[:latitude].present? && params[:longitude].present? && params[:distance].present?
      @header = "#{"Channels Near"}: [#{params[:latitude]}, #{params[:longitude]}]"
      @channels = Channel.location_search(params).paginate :page => params[:page]
    # normal channel list
    else
      @header = t(:featured_channels)
      @channels = Channel.public_viewable.active.order('ranking desc, updated_at DESC').paginate :page => params[:page]
    end

    respond_to do |format|
      format.html
      format.json { render :json => Channel.paginated_hash(@channels).to_json}
      format.xml { render :xml => Channel.paginated_hash(@channels).to_xml(:root => 'response')}
    end
  end

  # widget for social feeds
  def social_feed
    # get domain based on ssl
    @domain = domain((get_header_value('x_ssl') == 'true'))
  end

  def social_new
    @channel = Channel.now
  end

  # main page for a socialsensornetwork.com projet
  def social_show
    @channel = Channel.find_by_slug(params[:slug])

    # redirect home if wrong slug
    redirect_to '/' and return if @channel.nil?

    api_key = ApiKey.where(channel_id: @channel.id, write_flag: 1).first
    @post_url = "/update?key=#{api_key.api_key}"

    #name of non_blank channel fields
    @fields = []
    @channel.attribute_names.each do |attr|
      @fields.push(attr) if attr.index('field') and !@channel[attr].blank?
    end
  end

  def social_create
    @channel = Channel.new(channel_params)

    # check for blank name
    @channel.errors.add(:base, t(:social_channel_error_name_blank)) if @channel.name.blank?

    # check for blank slug
    @channel.errors.add(:base, t(:social_channel_error_slug_blank)) if @channel.slug.blank?

    # check for at least one field
    fields = false
    @channel.attribute_names.each do |attr|
      if (attr.index('field') or attr.index('status')) and !@channel[attr].blank?
        fields = true
        break
      end
    end
    @channel.errors.add(:base, t(:social_channel_error_fields)) if !fields

    # check for existing slug
    if @channel.errors.count == 0
      @channel.errors.add(:base, t(:social_channel_error_slug_exists)) if Channel.find_by_slug(@channel.slug)
    end

    # if there are no errors
    if @channel.errors.count == 0
      @channel.user_id = current_user.id
      @channel.social = true
      @channel.public_flag = true
      @channel.save

      # create an api key for this channel
      channel.add_write_api_key

      redirect_to channels_path
    else
      render :action => :social_new
    end

  end

  

end
