require "test_helper"

class TagDeleteTest < ActiveSupport::TestCase
  def setup
    @director = create(:director)
    @movie = create(:movie, director: @director)
    @tag = create(:tag, name: 'Action', movies: [@movie])
    @query_string = <<-GRAPHQL
    mutation DeleteTag($id:ID!) {
      tagDelete(input: {
        id: $id
      }){
        tag {
          id, name
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
    @result = ShaparencyProjectSchema.execute(@query_string, variables: { id: @tag.id })
    refute_nil @result['data']
  end

  test 'the tag is deleted' do
    assert_difference 'Tag.count', -1 do
      @result = ShaparencyProjectSchema.execute(@query_string, variables: { id: @tag.id })
    end
  end
end
