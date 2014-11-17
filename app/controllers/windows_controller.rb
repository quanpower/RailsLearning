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
  
end
