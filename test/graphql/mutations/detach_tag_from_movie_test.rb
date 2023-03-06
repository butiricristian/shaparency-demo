require "test_helper"

class DetachTagFromMovieTest < ActiveSupport::TestCase
  def setup
    @director = create(:director)
    @movie = create(:movie, director: @director)
    @tag = create(:tag, name: 'Action', movies: [@movie])
    @query_string = <<-GRAPHQL
    mutation RemoveTagFromMovie($tagId:ID!, $movieId:ID!) {
      detachTagFromMovie(input:{
        tagId:$tagId
        movieId:$movieId
      }) {
        tag {
          name
          movies {
            title
          }
        }
        movie {
          title
          tags {
            name
          }
        }
        errors {
          attribute
          message
        }
      }
    }
    GRAPHQL
  end

  test 'query is successful' do
    @result = ShaparencyProjectSchema.execute(@query_string, variables: { tagId: @tag.id, movieId: @movie.id })
    refute_nil @result['data']
  end

  test 'the movie is attached to the tag' do
    assert_difference '@tag.reload.movies.size', -1 do
      @result = ShaparencyProjectSchema.execute(@query_string, variables: { tagId: @tag.id, movieId: @movie.id })
    end
  end

  test 'the tag is attached to the movie' do
    assert_difference '@movie.reload.tags.size', -1 do
      @result = ShaparencyProjectSchema.execute(@query_string, variables: { tagId: @tag.id, movieId: @movie.id })
    end
  end
end
