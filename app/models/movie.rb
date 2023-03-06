class Movie < ApplicationRecord
  belongs_to :director
  has_and_belongs_to_many :tags
end
