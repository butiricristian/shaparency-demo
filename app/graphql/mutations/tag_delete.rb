# frozen_string_literal: true

module Mutations
  class TagDelete < BaseMutation
    description "Deletes a tag by ID"

    include ValidationErrorsConcern

    field :tag, Types::TagType, "The deleted tag"
    field :errors, [Types::ErrorType], "Errors occurred during deletion"

    argument :id, ID, "Id of the tag to be deleted", required: true

    def resolve(id:)
      tag = Tag.find(id)

      if tag.destroy
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
