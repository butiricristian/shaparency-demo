# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

directors = [
  Director.create!(name: "Steven Spielberg"),
  Director.create!(name: "Jeff Nichols"),
]
tags = [
  Tag.create!(name: "Action"),
  Tag.create!(name: "Emotional"),
  Tag.create!(name: "Dramatic"),
  Tag.create!(name: "Family"),
  Tag.create!(name: "Fun"),
]
movies = [
  Movie.create!(title: "Little Fish", director: directors.first, tags: [tags[1], tags[3]]),
  Movie.create!(title: "Thunder Road", director: directors.first, tags: [tags[0], tags[1], tags[4]]),
  Movie.create!(title: "Midnight Special", director: directors.second, tags: [tags[0], tags[4]])
]
