# frozen_string_literal: true

module Types
  class ErrorType < Types::BaseObject
    field :attribute, String, "The attribute for which validation failed"
    field :message, String, "The validation failed message"
  end
end
