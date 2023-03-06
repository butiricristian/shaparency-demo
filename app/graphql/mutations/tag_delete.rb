# frozen_string_literal: true

module Mutations
  class TagDelete < BaseMutation
    description "Deletes a tag by ID"

    field :tag, Types::TagType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      tag = Tag.find(id)
      raise GraphQL::ExecutionError.new "Error deleting tag", extensions: tag.errors.to_hash unless tag.destroy

      { tag: tag }
    end
  end
end
