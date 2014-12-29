class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    permitted_params = params.require(:message).permit(:subject, :body, :attachment)
    message = Message.new(permitted_params)
    if message.valid?
      SampleMailer.notice(message).deliver
      redirect_to '/inbox'
    else
      redirect_to '/'
    end

  end

end
