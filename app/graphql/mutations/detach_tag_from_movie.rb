module Mutations
  class DetachTagFromMovie < BaseMutation
    field :tag, Types::TagType, null: false
    field :movie, Types::MovieType

    argument :tag_id, ID, required: true
    argument :movie_id, ID, required: true

    def resolve(tag_id:, movie_id:)
      tag = Tag.find(tag_id)
      movie = Movie.find(movie_id)
      tag.movies.delete(movie)
      raise GraphQL::ExecutionError.new "Error detaching tag from movie", extensions: tag.errors.to_hash unless tag.save

      {
        tag: tag,
        movie: movie
      }
    end
  end
end
