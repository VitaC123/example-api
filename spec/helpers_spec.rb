require_relative './spec_helper.rb'
require_relative '../example_api.rb'
require_relative '../helpers.rb'

describe 'QueryHelpers' do
  include Rack::Test::Methods

  subject do
    Class.new { include QueryHelpers }
  end

  queryText = 'SELECT * FROM users'

  it 'adds `params[:sort_by]` to SQL query, when param is not nil' do
    expect(subject.new.build_query_users(sort_by: nil)).to eq(queryText)
    expect(subject.new.build_query_users(sort_by: 'username')).to eq("#{queryText} ORDER BY username")
    expect(subject.new.build_query_users(sort_by: 'releases')).to eq("#{queryText} ORDER BY release_count")
    expect(subject.new.build_query_users(sort_by: 'downloads')).to eq("#{queryText} ORDER BY downloads")
    expect(subject.new.build_query_users(sort_by: 'latest_release')).to eq("#{queryText} ORDER BY latest_release")
  end

  it 'adds `params[:limit] to SQL query, when param is not nil`' do
    expect(subject.new.build_query_users(limit: nil)).to eq(queryText)
    expect(subject.new.build_query_users(limit: '5')).to eq("#{queryText} LIMIT 5")
    expect(subject.new.build_query_users(limit: 15)).to eq("#{queryText} LIMIT 15")
  end

  it 'adds `params[:offset] to SQL query, when param is not nil`' do
    expect(subject.new.build_query_users(offset: nil)).to eq(queryText)
    expect(subject.new.build_query_users(offset: '5')).to eq("#{queryText} OFFSET 5")
    expect(subject.new.build_query_users(offset: 15)).to eq("#{queryText} OFFSET 15")
  end
end
