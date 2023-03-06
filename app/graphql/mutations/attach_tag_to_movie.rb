module Mutations
  class AttachTagToMovie < BaseMutation
    field :tag, Types::TagType, null: false
    field :movie, Types::MovieType

    argument :tag_id, ID, required: true
    argument :movie_id, ID, required: true

    def resolve(tag_id:, movie_id:)
      tag = Tag.find(tag_id)
      movie = Movie.find(movie_id)
      tag.movies << movie
      raise GraphQL::ExecutionError.new "Error attaching tag to movie", extensions: tag.errors.to_hash unless tag.save

      {
        tag: tag,
        movie: movie
      }
    end
  end
end
