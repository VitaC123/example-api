require 'sinatra/base'
require 'json'
require_relative 'helpers.rb'

class ExampleApi < Sinatra::Application
  use Rack::Deflater # Sets 'Content-Encodeing': 'gzip'
  helpers QueryHelpers

  before do
    # If-Modified-Since Mon, 16 Dec 2017 22:09:00 GMT
    puts headers
  end

  get '/' do
    erb :index
  end

  get '/users' do
    @queryText = build_query_users(params)
    @users = JSON.pretty_generate(DB.fetch(@queryText).all)
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
