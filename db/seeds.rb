# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
[[Dish,'dishes'],
[Ingredient,'ingredients'],
[Composition,'compositions'],[Subscriber,'subscribers'],[Exclusion,'exclusions']].each do |entity|
  entity[0].delete_all
  file = Rails.root.join('db', "#{entity[1]}.yml")
  config = YAML::load_file(file)
  entity[0].create!(config)
end
