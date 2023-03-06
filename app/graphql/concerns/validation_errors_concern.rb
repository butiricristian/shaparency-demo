module ValidationErrorsConcern
  include ActiveSupport::Concern

  def validation_errors(object)
    validation_errors = object.errors.to_hash.map do |attribute, message|
      {
        attribute: attribute.to_s.camelize(:lower),
        message: message.join(", "),
      }
    end
  end
end
