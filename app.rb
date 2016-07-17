RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)
require_relative 'message'

class App < Sinatra::Base
  set :assets_css_compressor, :yui
  set :assets_js_compressor,  :uglifier
  register Padrino::Helpers
  register Sinatra::AssetPipeline

  set :root, File.dirname(__FILE__)
  Goatmail.location = File.join("#{root}/tmp/goatmail")
  Pony.options = { via: Goatmail::DeliveryMethod }

  get '/' do
    @message = Message.new
    render :index
  end

  post '/' do
    @message = Message.new(params[:message])
    if @message.valid?
      if @message.attachment.present?
        files = { @message.attachment[:filename] => File.read(@message.attachment[:tempfile].path) }
      end
      Pony.mail(
        from:         "from@example.com",
        to:           "to@example.com",
        subject:      @message.subject,
        body:         @message.body,
        html_body:    slim(:notice, layout: false),
        attachments:  files
      )
      redirect '/inbox'
    else
      redirect '/'
    end
  end

end
