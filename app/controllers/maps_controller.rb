class MapsController < ApplicationController

  # show map with channel's location
  def channel_show
    set_map_vars
    render :layout => false
  end
  


end
