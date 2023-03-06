# frozen_string_literal: true

module Types
  class DirectorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :movies, Types::MovieType.connection_type
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
