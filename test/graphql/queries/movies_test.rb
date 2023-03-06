require "test_helper"

class MoviesTest < ActiveSupport::TestCase
  def setup
    @director = create(:director)
    @movie_1 = create(:movie, title: 'Spiderman', rating: 5, director: @director)
    @movie_2 = create(:movie, title: 'Batman', rating: 7, director: @director)
  end

  test 'query is successful' do
    query_string = <<-GRAPHQL
    query movies {
      movies {
        id
        title
      }
    }
    GRAPHQL
    result = ShaparencyProjectSchema.execute(query_string)
    refute_nil result['data']
  end

  test 'query returns all movies' do
    query_string = <<-GRAPHQL
    query movies {
      movies {
        id
        title
      }
    }
    GRAPHQL
    result = ShaparencyProjectSchema.execute(query_string)
    assert_equal result.dig('data', 'movies').size, 2
    assert_equal result.dig('data', 'movies').first['title'], @movie_1.title
  end

  test 'query returns movies filtered by search term' do
    query_string = <<-GRAPHQL
    query movies {
      movies(titleQuery: "spider") {
        id
        title
      }
    }
    GRAPHQL
    result = ShaparencyProjectSchema.execute(query_string)
    assert_equal result.dig('data', 'movies').size, 1
    assert_equal result.dig('data', 'movies').first['id'], @movie_1.id.to_s
  end

  test 'query returns movies with rating less than 6' do
    query_string = <<-GRAPHQL
    query movies {
      movies(ratingLt: 6) {
        id
        title
      }
    }
    GRAPHQL
    result = ShaparencyProjectSchema.execute(query_string)
    assert_equal result.dig('data', 'movies').size, 1
    assert_equal result.dig('data', 'movies').first['id'], @movie_1.id.to_s
  end

  test 'query returns movies with rating greater than 6' do
    query_string = <<-GRAPHQL
    query movies {
      movies(ratingGt: 6) {
        id
        title
      }
    }
    GRAPHQL
    result = ShaparencyProjectSchema.execute(query_string)
    assert_equal result.dig('data', 'movies').size, 1
    assert_equal result.dig('data', 'movies').first['id'], @movie_2.id.to_s
  end

  test 'query returns movies with rating equal to 6' do
    query_string = <<-GRAPHQL
    query movies {
      movies(ratingEq: 6) {
        id
        title
      }
    }
    GRAPHQL
    result = ShaparencyProjectSchema.execute(query_string)
    assert_equal result.dig('data', 'movies').size, 0
  end
end
