require "test_helper"

class DirectorsTest < ActiveSupport::TestCase
  def setup
    @directors = create_list(:director, 3)
    @movies = create_list(:movie, 2, director: @directors.first)

    @query_string = <<-GRAPHQL
    query {
      directors {
        id
        name
        movies {
          edges {
            node {
              title
            }
          }
          pageInfo {
            endCursor
            hasNextPage
          }
        }
      }
    }
    GRAPHQL
    @result = ShaparencyProjectSchema.execute(@query_string)
  end

  test 'query is successful' do
    refute_nil @result['data']
  end

  test 'query returns director data' do
    assert_equal @result.dig('data', 'directors').size, 3
    assert_equal @result.dig('data', 'directors').first['name'], @directors.first.name
  end

  test 'query returns director movies data as collection' do
    movies = @result.dig('data', 'directors', 0, 'movies')
    refute_nil movies['edges']
    refute_nil movies['pageInfo']
  end

  test 'query returns director movies data' do
    movies = @result.dig('data', 'directors', 0, 'movies', 'edges')
    assert_equal movies.size, 2
    assert_equal movies.first.dig('node', 'title'), @movies.first.title
  end
end
