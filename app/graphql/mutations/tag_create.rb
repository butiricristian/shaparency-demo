# frozen_string_literal: true

module Mutations
  class TagCreate < BaseMutation
    description "Creates a new tag"

    include ValidationErrorsConcern

    field :tag, Types::TagType, "The created tag"
    field :errors, [Types::ErrorType], "Errors occurred during creation"

    argument :name, String, "Name of the tag - must be unique", required: true
    argument :movie_id, ID, "An optional movie id to which to attach the tag", required: false

    def resolve(name:, movie_id: nil)
      tag = Tag.new(name: name)
      tag.movie_ids << movie_id if movie_id.present?

      if tag.save
        {
          tag: tag,
          errors: []
        }
      else
        { errors: validation_errors(tag) }
      end
    end
  end
end
