require 'sinatra'

module QueryHelpers
  def build_query_users(params)
    queryText = 'SELECT * FROM users'

    if params[:sort_by]
      sort_by = params[:sort_by]
      queryText << ' ORDER BY '
      if sort_by == 'releases'
        queryText <<  'release_count'
      else
        queryText <<  sort_by
      end
    end

    queryText << " LIMIT #{params[:limit]}" if params[:limit]

    queryText << " OFFSET #{params[:offset]}" if params[:offset]

    queryText
  end
end

Sinatra::Application.helpers QueryHelpers
