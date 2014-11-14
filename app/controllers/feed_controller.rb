class FeedController < ApplicationController
  include FeedHelper
  require 'csv'
  layout 'application', :except => [:index, :debug]

  def index
    feed_factory = FeedFactory.new(params)
    channel = feed_factory.channel
    api_key = ApiKey.find_by_api_key(get_apikey)
    @success = channel_permission?(channel, api_key)

    # set callback for json
    @callback = params[:callback] if params[:callback]

    # set csv headers if necessary
    @csv_headers = feed_factory.feed_select_options if params[:format] == 'csv'

    # check for access
    if @success

      if feed_factory.cache_feeds
        # check cache for stored value
        feed_output_cache_key = cache_key('feed_output')
        channel_output_cache_key = cache_key('channel_output')
        @feed_output = Rails.cache.read(feed_output_cache_key)
        @channel_output = Rails.cache.read(channel_output_cache_key)
      end

      # if cache miss, get data
      if @feed_output.nil? or @channel_output.nil?

        # get feeds
        feeds = feed_factory.get_output_feeds

        # set output correctly
        if params[:format] == 'xml'
          @channel_output = channel.to_xml(channel.select_options(params)).sub('</channel>', '').strip
          @feed_output = feeds.to_xml(:skip_instruct => true).gsub(/\n/, "\n  ").chop.chop
        elsif params[:format] == 'csv'
          @feed_output = feeds
        else
          @channel_output = channel.to_json(channel.select_options(params)).chop
          @feed_output = feeds.to_json(:only => feed_factory.feed_select_options)
        end

        if feed_factory.cache_feeds
          # save to cache
          Rails.cache.write(feed_output_cache_key, @feed_output, :expires_in => 5.minutes)
          Rails.cache.write(channel_output_cache_key, @channel_output, :expires_in => 5.minutes)
        end
      end #end if feeds not empty
    # else no access, set error code
    else
      if params[:format] =='xml'
        @channel_output = bad_channel_xml
      else
        @channel_output = '-1'.to_json
      end
    end

    # output proper http response if error
    render :text => '-1', :status => 400 and return if !@success

    #output data in proper format
    respond_to do |format|
      format.html
      format.json
      format.xml
      format.csv
    end
  end

  def last_sum
    last_method = method('last_group_call')
    last_method.call('sums')
  end

  def last_median
    last_method = method('last_group_call')
    last_method.call('medians')
  end

  def last_average
    last_method = method('last_group_call')
    last_method.call('averages')
  end

end
