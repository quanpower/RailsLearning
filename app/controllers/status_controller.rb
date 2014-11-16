class StatusController < ApplicationController
  require 'csv'
  layout false

  def recent
    logger.info "Domain is #{@domain}"
    channel = Channel.find(params[:channel_id])
    @channel_id = channel.id
    if channel.public_flag || (current_user && current_user.id == channel.user_id)
      @statuses = channel.recent_statuses
      respond_to do |format|
        format.html { render :partial => 'status/recent' }
        format.json { render :json => @statuses}
      end
    else
      respond_to do |format|
        format.json { render :json => 'Statuses are not public'}
        format.html { render :text => 'Sorry the statuses are not public'}
      end
    end
  end

  
end
