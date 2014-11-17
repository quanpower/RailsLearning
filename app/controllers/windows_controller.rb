class WindowsController < ApplicationController
  before_filter :require_user, :except => [:index, :html, :iframe]

  def hide
    window = Window.find(params[:id])
    window.show_flag = false
    if window.save
      render :text => window.id.to_s
    else
      render :text => '-1'
    end
  end

  # Call WindowsController.display when we want to display a window on the dashboard
  # params[:visibility_flag] is whether it is the private or public dashboard
  # params[:plugin] is for displaying a plugin, instead of a window
  # params[:id] is the window ID for conventional windows, but the plugin_id for plugins
  # params[:channel_id] is the channel_id
  def display
    @visibility = params[:visibility_flag]

    window = Window.find(params[:id])
    window = Window.new if window.nil?
    window.show_flag = true
    #Just save this change, then modify the object before rendering the JSON

    saveWindow = window.save

    config_window window

    @mychannel = current_user && current_user.id == window.channel.user_id

    if saveWindow
      render :json => window.to_json
    else
      render :json => 'An error occurred'.to_json
    end
  end

  

end
