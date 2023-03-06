# frozen_string_literal: true

module Mutations
  class TagCreate < BaseMutation
    description "Creates a new tag"

    field :tag, Types::TagType, null: false

    argument :name, String, required: true
    argument :movie_id, ID, required: false

    def resolve(name:, movie_id: nil)
      tag = Tag.new(name: name)
      tag.movie_ids << movie_id if movie_id.present?
      raise GraphQL::ExecutionError.new "Error creating tag", extensions: tag.errors.to_hash unless tag.save

      { tag: tag }
    end
  end
end
