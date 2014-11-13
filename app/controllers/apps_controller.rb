class AppsController < ApplicationController

  def index
    @menu = 'apps'
    @title = 'SmartLinkCloud Apps' if current_user.nil?
  end
end
