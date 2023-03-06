module Types
  class MutationType < Types::BaseObject
    field :detach_tag_from_movie, mutation: Mutations::DetachTagFromMovie
    field :attach_tag_to_movie, mutation: Mutations::AttachTagToMovie
    field :tag_delete, mutation: Mutations::TagDelete
    field :tag_create, mutation: Mutations::TagCreate
  end
end
