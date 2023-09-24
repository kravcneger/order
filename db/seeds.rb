# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

connection = ActiveRecord::Base.connection

entities = [[Ingredient,'ingredients'],
[Dish,'dishes'],
[Composition,'compositions'],
]

unless ENV["without_subscribers"]  
  entities << [Subscriber,'subscribers']
  entities << [Exclusion,'exclusions']
end

entities.reverse.each do |entity|
  entity[0].delete_all
end

entities.each do |entity|
  file = Rails.root.join('db', "#{entity[1]}.yml")
  config = YAML::load_file(file)
  entity[0].create!(config)

  # фиксит проблему с аутоинкрементами
  if ['dishes', 'ingredients', 'subscribers'].include?(entity[1])
    connection.execute("SELECT setval(pg_get_serial_sequence(\'#{entity[1]}\', 'id'), MAX(id)) FROM #{entity[1]};")
  end
end
