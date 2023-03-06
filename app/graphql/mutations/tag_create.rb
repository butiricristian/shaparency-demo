# frozen_string_literal: true

module Mutations
  class TagCreate < BaseMutation
    description "Creates a new tag"

    field :tag, Types::TagType, "The created tag"
    field :errors, [Types::ErrorType], "Errors occurred during creation"

    argument :name, String, required: true
    argument :movie_id, ID, required: false

    def resolve(name:, movie_id: nil)
      tag = Tag.new(name: name)
      tag.movie_ids << movie_id if movie_id.present?

      if tag.save
        {
          tag: tag,
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
