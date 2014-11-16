class PluginsController < ApplicationController
  before_filter :authenticate_via_api_key! :only => [:index]
  before_filter :require_user, :except => [:show_public, :show, :public]
  before_filter :set_plugins_menu
  before_filter :check_permission, :only => ['edit', 'update', 'ajax_update', 'destroy']

  def check_permission
    @plugin = Plugin.find(params[:id])
    respond_with_error(:error_auth_required) and return if current_user.blank? || (@plugin.user_id != current_user.id)
  end

  def new; ; end
  def edit; ; end

  # get list of public plugins
  def public
    # error if page 0
    respond_with_error(:error_resource_not_found) and return if params[:page] == '0'

    # default blank response
    @plugins = Plugin.where(:id => 0).paginate :page => params[:page]

    # get plugins
    @plugins = Plugin.where("public_flag = true").order('updated_at DESC').paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.json { render :json => Plugin.paginated_hash(@plugins).to_json}
      format.xml { render :xml => Plugin.paginated_hash(@plugins).to_xml(:root => 'response')}
    end
  end

  def index
    @plugins = current_user.plugins
    respond_to do |format|
      format.html
      format.json { render :json => @plugins.to_json(Plugin.public_options) }
      format.xml { render :xml => @plugins.to_xml(Plugin.public_options) }
    end
  end

  def public_plugins
    channel_id = params[:channel_id].to_i
    return if channel_id.nil?
    @plugin_windows = []
    plugins = current_user.plugins
    plugins.each do |plugin|
      plugin.make_windows channel_id, api_domain #will only make the window the first time
      @plugin_windows = @plugin_windows + plugin.public_dashboard_windows(channel_id)
    end

    respond_to do |format|
      format.html { render :partial => 'plugins'}
    end
  end

  
end
