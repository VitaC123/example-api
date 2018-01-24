require_relative './spec_helper.rb'
require_relative '../example_api.rb'
require_relative '../helpers.rb'

describe 'QueryHelpers' do
  include Rack::Test::Methods

  subject do
    Class.new { include QueryHelpers }
  end

  query_text = 'SELECT * FROM "users"'

  it 'adds `params[:sort_by]` to SQL query, when param is not nil' do
    expect(subject.new.build_query_users(sort_by: nil).sql).to eq(query_text)
    expect(subject.new.build_query_users(sort_by: 'username').sql).to eq("#{query_text} ORDER BY \"username\"")
    expect(subject.new.build_query_users(sort_by: 'releases').sql).to eq("#{query_text} ORDER BY \"release_count\"")
    expect(subject.new.build_query_users(sort_by: 'downloads').sql).to eq("#{query_text} ORDER BY \"downloads\"")
    expect(subject.new.build_query_users(sort_by: 'latest_release').sql).to eq("#{query_text} ORDER BY \"latest_release\"")
  end

  it 'adds `params[:limit] to SQL query, when param is not nil`' do
    expect(subject.new.build_query_users(limit: nil).sql).to eq(query_text)
    expect(subject.new.build_query_users(limit: '5').sql).to eq("#{query_text} LIMIT 5")
    expect(subject.new.build_query_users(limit: 15).sql).to eq("#{query_text} LIMIT 15")
  end

  it 'adds `params[:offset] to SQL query, when param is not nil`' do
    expect(subject.new.build_query_users(offset: nil).sql).to eq(query_text)
    expect(subject.new.build_query_users(offset: '5').sql).to eq("#{query_text} OFFSET 5")
    expect(subject.new.build_query_users(offset: 15).sql).to eq("#{query_text} OFFSET 15")
  end
end
