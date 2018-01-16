module QueryHelpers

  def build_query_users(params)
    queryText = "SELECT * FROM users"

    if params[:sort_by]
      queryText << " ORDER BY #{params[:sort_by]}"
    end

    if params[:limit]
      queryText << " LIMIT #{params[:limit]}"
    end

    if params[:offset]
      queryText << " OFFSET #{params[:offset]}"
    end

    queryText
  end
  
end
