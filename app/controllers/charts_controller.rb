class ChartsController < ApplicationController
  before_filter :require_user, :only => [:edit]

  def edit
    # params[:id] is the windows ID
    @channel = current_user.channels.find(params[:channel_id])

    window_id = params[:id]
    logger.debug "Windows ID is #{window_id}"
    window = @channel.windows.find(window_id)
    options = window.options unless window.nil?
    logger.debug "Options for window #{window_id} are" + options.inspect

    render :partial => "charts/config", :locals => {
        :displayconfig => false,
        :title => @channel.name,
        :src => "/channels/#{@channel.id}/charts/#{window_id}",
        :options => options,
        :index => window_id,
        :width => Chart.default_width,
        :height => Chart.default_height
    }
  end

  def index
    set_channels_menu
    @channel = Channel.find(params[:channel_id])
    @channel_id = params[:channel_id]
    @domain = domain

    # default chart size
    @width = Chart.default_width
    @height = Chart.default_height

    check_permissions(@channel)
  end

end
