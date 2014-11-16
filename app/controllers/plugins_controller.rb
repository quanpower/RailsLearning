class PluginsController < ApplicationController
  before_filter :authenticate_via_api_key! :only => [:index]
  before_filter :require_user, :except => [:show_public, :show, :public]
  before_filter :set_plugins_menu
  before_filter :check_permission, :only => ['edit', 'update', 'ajax_update', 'destroy']

  def check_permission
    @plugin = Plugin.find(params[:id])
    respond_with_error(:error_auth_required) and return if current_user.blank? || (@plugin.user_id != current_user.id)
  end
end
