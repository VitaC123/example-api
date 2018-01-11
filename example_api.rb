require 'sinatra/base'
require 'json'

class ExampleApi < Sinatra::Application
  use Rack::Deflater # Sets 'Content-Encodeing': 'gzip'

  get '/' do
    erb :index
  end

  get '/users' do
    @users = JSON.pretty_generate(DB[:users].all)
    erb :json_response
  end

  get '/users/:user' do
    target_user = DB[:users].where(username: params[:user]).first
    @users = JSON.pretty_generate(target_user)
    erb :json_response
  end

  after do
    headers['Date'] = Time.now.to_s
    headers['Cache-control'] = 'public, must-revalidate'
  end
end
