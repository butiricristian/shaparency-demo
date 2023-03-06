require "test_helper"

class TagCreateTest < ActiveSupport::TestCase
  def setup
    @query_string = <<-GRAPHQL
    mutation CreateTag($name: String!, $movieId: ID) {
      tagCreate(input: {name: $name, movieId: $movieId}) {
        tag {
          id
          name
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
    @result = ShaparencyProjectSchema.execute(@query_string, variables: { name: "Action" })
    refute_nil @result['data']
  end

  test 'a new tag is created' do
    assert_equal Tag.count, 0
    @result = ShaparencyProjectSchema.execute(@query_string, variables: { name: "Action" })
    assert_equal Tag.count, 1
  end

  test 'query is unsuccessful' do
    tag = create(:tag, name: 'Action')
    result = ShaparencyProjectSchema.execute(@query_string, variables: { name: "Action" })
    assert_equal result.dig('data', 'tagCreate', 'errors').size, 1
  end
end
