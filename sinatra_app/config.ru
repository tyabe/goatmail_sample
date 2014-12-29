require_relative 'app'

map '/' do
  run App.new
end

map '/inbox' do
  run Goatmail::App.new
end
