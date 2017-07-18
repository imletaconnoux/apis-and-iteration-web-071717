require 'rest-client'
require 'json'
require 'pry'

def character_films(character_hash, character)
  films_array = []
  character_hash["results"].each do |characters|
    if characters["name"].downcase == character
    films_array = characters["films"]
    end
  end
  films_array
end

def character_film_hash(films_array)
  films_hash = films_array.collect do |film|
    JSON.parse(RestClient.get(film))
  end
  films_hash
end

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films_array = character_films(character_hash, character)
  films_hash = character_film_hash(films_array)
  films_hash
end
# films_hash = get_character_movies_from_api("Luke Skywalker")
def parse_character_movies(films_hash)
  films_hash.each_with_index do |film, idx|
    puts "#{idx+1}: #{film["title"]}"
  end

end
# parse_character_movies(films_hash)
def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
