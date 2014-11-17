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

  def config_window(window)
    if window.window_type = "plugin"
      pluginName = Plugin.find(window.content_id).name
      window.title = t(window.title, {:name => pluginName})
    elsif window.window_type == "chart"
      window.title = t(window.title, {:field_number => window.content_id})
      options = window.options if !window.nil?
      options ||= ""
      window.html["::OPTIONS::"] = options unless window.html.nil? || window.html.index("::OPTIONS::").nil?
    else
      window.title = t(window.title)
    end
  end

  def html
    window = Window.find(params[:id])
    options = window.options unless window.nil? || window.window_type != "chart"
    window.html["::OPTIONS::"] = options unless window.html.nil? || window.html.index("::OPTIONS::").nil?
    html = window.html

    render :text => html
  end

  def iframe
    window = Window.find(params[:id])
    options = window.options unless window.nil? || window.window_type != "chart"
    window.html["::OPTIONS::"] = options unless window.html.nil? || window.html.index("::OPTIONS::").nil?
    iframe_html = window.html

    iframe_html = iframe_html.gsub(/src=\"[\/.]/, 'src="' + api_domain);
    render :text => iframe_html
  end

  def index
    channel = Channel.find(params[:channel_id])
    windows = channel.public_windows(true).order(:position) unless params[:channel_id].nil?

    if channel.recent_statuses.nil? || channel.recent_statuses.size <= 0
      @windows = windows.delete_if { |w| w.window_type == "status" }
    else
      @windows = windows
    end

    @windows.each do |window|

      if window.window_type == "plugin"
        pluginName = Plugin.find(window.content_id).name
        window.title = t(window.title, {:name => pluginName})
      elsif window.window_type == "chart"
        window.title = t(window.title, {:field_number => window.content_id})
        options = window.options if !window.nil?
        options ||= ""
        window.html["::OPTIONS::"] = options unless window.html.nil? || window.html.index("::OPTIONS::").nil?
      else
        window.title = t(window.title)
      end
    end

    respond_to do |format|
      format.html
      format.json { render :json => @windows.as_json }
    end
  end

  # This is going to display windows that are hidden (show_flag = false)
  # The "Visibility_flag" param indicates whether it's public or private visibility
  def hidden_windows
    @visibility = params[:visibility_flag]
    channel = Channel.find(params[:channel_id])

    if @visibility == "private"
      @windows = channel.private_windows(false) unless channel.nil?
    else
      @windows = channel.public_windows(false) unless channel.nil?
    end
    @windows.reject! { |window| window.window_type == "plugin" }
    @windows.each do |window|
      if window.window_type == "plugin"
      elsif window.window_type == "chart"
        window.title = t(window.title, {:field_number => window.content_id})
        options = window.options unless window.nil?
        options ||= ""
        window.html["::OPTIONS::"] = options unless window.html.nil? || window.html.index("::OPTIONS::").nil?
      else
        window.title = t(window.title)
      end
    end

    respond_to do |format|
      format.html { render :partial => "hidden_windows" }
      format.json { render :json => @windows.as_json }
    end
  end

end
