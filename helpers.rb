require 'sinatra'

module QueryHelpers
  def build_query_users(params)
    query = DB[:users]

    if params[:sort_by]
      sort_by = if params[:sort_by] == 'releases' then 'release_count' else params[:sort_by] end
      query = query.order(sort_by.to_sym)
    end

    query = query.offset(params[:offset]) if params[:offset]

    query = query.limit(params[:limit]) if params[:limit]

    query
  end
end

Sinatra::Application.helpers QueryHelpers
