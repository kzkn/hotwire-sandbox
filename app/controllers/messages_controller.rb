class MessagesController < ApplicationController
  before_action :set_room

  def index
    respond_to do |format|
      format.turbo_stream
    end
  end

  def new
    @message = @room.messages.build
  end

  def create
    @message = @room.messages.create!(message_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @room }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
