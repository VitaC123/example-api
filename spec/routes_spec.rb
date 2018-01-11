require_relative './spec_helper.rb'
require_relative '../example_api.rb'

describe 'routes' do
  include Rack::Test::Methods

  def app
    ExampleApi.new
  end

  it 'handles GET `/` by serving the home page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Example API')
  end

  it 'handles GET `/users` by returning an array of user data' do
    get '/users'
    expect(last_response).to be_ok
    expect(last_response.body).to include('<pre>[')
    expect(last_response.body).to include(']</pre>')
  end

  it 'handles GET `/users/:user` by returning one user\'s data' do
    get '/users/001john'
    expect(last_response).to be_ok
    expect(last_response.body).to include('<pre>{')
    expect(last_response.body).to include('}</pre>')
  end
end
