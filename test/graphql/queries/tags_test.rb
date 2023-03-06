require "test_helper"

class TagsTest < ActiveSupport::TestCase
  def setup
    @director = create(:director)
    @movie_1 = create(:movie, title: 'Spiderman', rating: 5, director: @director)
    @movie_2 = create(:movie, title: 'Batman', rating: 7, director: @director)
    @movie_3 = create(:movie, title: 'Shallow', rating: 8, director: @director)
    @tag_1 = create(:tag, name: 'Super Heroes', movies: [@movie_1, @movie_2])
    @tag_2 = create(:tag, name: 'Drama', movies: [@movie_3])
    @query_string = <<-GRAPHQL
    query {
      tags {
        id
        name
        movies {
          title
          director {
            name
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

  test 'query returns tags data' do
    assert_equal @result.dig('data', 'tags').size, 2
    assert_equal @result.dig('data', 'tags').first['name'], @tag_1.name
  end

  test 'query returns movies data' do
    movies = @result.dig('data', 'tags', 0, 'movies')
    assert_equal movies.size, 2
    assert_equal movies.first['title'], @movie_1.title
  end
end
