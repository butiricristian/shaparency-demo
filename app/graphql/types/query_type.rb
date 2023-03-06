module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :directors,
    [Types::DirectorType],
    null: false,
    description: "Return a list of directors"

    field :movies,
    [Types::MovieType],
    null: false,
    description: "Return a list of movies" do
      argument :title_query, String, required: false
      argument :rating_lt, Integer, required: false
      argument :rating_eq, Integer, required: false
      argument :rating_gt, Integer, required: false
    end

    field :tags,
    [Types::TagType],
    null: false,
    description: "Return a list of tags"

    def directors
      Director.all
    end

    def movies(title_query: nil, rating_lt: nil, rating_eq: nil, rating_gt: nil)
      movies = Movie.all

      if title_query.present?
        movies = movies.where("title ILIKE ?", "%#{title_query}%")
      end
      if rating_lt.present?
        movies = movies.where("rating < ?", rating_lt)
      end
      if rating_eq.present?
        movies = movies.where("rating = ?", rating_eq)
      end
      if rating_gt.present?
        movies = movies.where("rating > ?", rating_gt)
      end

      movies
    end

    def tags
      Tag.all
    end
  end
end
