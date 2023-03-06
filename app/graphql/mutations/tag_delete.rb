# frozen_string_literal: true

module Mutations
  class TagDelete < BaseMutation
    description "Deletes a tag by ID"

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
