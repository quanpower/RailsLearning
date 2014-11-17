class TagsController < ApplicationController

  def index

    render 'show' and return if params[:channel_id].nil?

    channel = Channel.find(params[:channel_id])
    if current_user && channel.nil?
      tag = Tag.find_by_name(params[:id], :include => :channels, :conditions => ['channels.public_flag = true OR channels.user_id = ?', current_user.id])
    else
      channels = []
      channel.tags.each do |tag|
        channels << tag.channel_ids
      end

      channels = channels.flatten.uniq
    end
    redirect_to public_channels_path(:channel_ids => channels)

  end

  def create

  end

  def show

  end

end

