require 'sinatra/base'
require 'json'
require_relative 'helpers.rb'
require 'time'

class ExampleApi < Sinatra::Application
  use Rack::Deflater # Sets 'Content-Encodeing': 'gzip'
  helpers QueryHelpers

  get '/' do
    erb :index
  end

  get '/users' do
    @queryText = build_query_users(params).sql
    @users = JSON.pretty_generate(DB.fetch(@queryText).all)
    erb :json_response
  end

  get '/users/:user' do
    target_user = DB[:users].where(username: params[:user]).first
    @users = JSON.pretty_generate(target_user)
    erb :json_response
  end

  after do
    headers['Date'] = Time.now.httpdate
    headers['Cache-control'] = 'public, must-revalidate'
  end
end
