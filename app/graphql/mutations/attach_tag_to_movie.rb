module Mutations
  class AttachTagToMovie < BaseMutation
    include ValidationErrorsConcern

    field :tag, Types::TagType
    field :movie, Types::MovieType
    field :errors, [Types::ErrorType], "Errors occurred while attaching"

    argument :tag_id, ID, "The id of the tag to be attached", required: true
    argument :movie_id, ID, "The id of the movie to which the tag will be attached", required: true

    def resolve(tag_id:, movie_id:)
      tag = Tag.find(tag_id)
      movie = Movie.find(movie_id)
      tag.movies << movie

      if tag.save
        {
          tag: tag,
          movie: movie,
          errors: []
        }
      else
        { errors: validation_errors(tag) }
      end
    end
  end
end
