PadrinoApp::App.controllers  do

  get :index do
    @message = Message.new
    render :index
  end

  post :create, map: '/', params: { message: [:subject, :body, :attachment] } do
    message = Message.new(params[:message])
    if message.valid?
      deliver(:sample, :notice, message)
      redirect '/inbox'
    else
      redirect '/'
    end
  end
end
