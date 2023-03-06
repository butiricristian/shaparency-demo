module Mutations
  class DetachTagFromMovie < BaseMutation
    field :tag, Types::TagType
    field :movie, Types::MovieType

    argument :tag_id, ID, required: true
    argument :movie_id, ID, required: true
    field :errors, [Types::ErrorType], "Errors occurred during detaching"

    def resolve(tag_id:, movie_id:)
      tag = Tag.find(tag_id)
      movie = Movie.find(movie_id)
      tag.movies.delete(movie)

      if tag.save
        {
          tag: tag,
          movie: movie,
          errors: []
        }
      else
        validation_errors = tag.errors.to_hash.map do |attribute, message|
          {
            attribute: attribute.to_s.camelize(:lower),
            message: message.join(", "),
          }
        end
        {
          errors: validation_errors
        }
      end
    end
  end
end
