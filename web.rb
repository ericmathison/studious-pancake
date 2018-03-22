require 'sinatra/base'
require 'json'
require 'pp'
require_relative 'snake'

class BattleSnake < Sinatra::Base
  before { content_type "application/json" }

  get '/' do
    {
      "color"=> "#ffffff",
      "head_url"=> "url/to/your/img/file"
    }.to_json
  end

  post '/start' do
    json_string = request.body.read
    _request = json_string ? JSON.parse(json_string) : {}

    # Get ready to start a game with the request data
    colour = "%06x" % (rand * 0xffffff)
    taunt = ["This isn't your moms Ruby in Hollywood", "This isn't your dads Ruby in Hollywood", "Get outta town!", "Come and get me!", "Gotta get that food!", "I'm tired of these muther fucking snakes in the mother fucking code!"]
    head = %w|bendr dead fang pixel regular safe sand-worm shades smile tongue|.sample
    tail = %w|block-bum curled fat-rattle freckled pixel regular round-bum skinny small-rattle|.sample
    response = {
      "taunt" => taunt.sample,
      "color" => "##{colour}",
      "head_type" => head,
      "tail_type" => tail
    }
    # Dummy response
    taunt = ["This isn't your moms Ruby in Hollywood", "This isn't your dads Ruby in Hollywood", "Get outta town!"].sample
    response = {
      "taunt" => taunt,
    }

    response.to_json
  end

  post '/move' do
    requestBody = request.body.read
    requestJson = requestBody ? JSON.parse(requestBody) : {}

    snake = Snake.new(requestJson['you'])
    foods = Food.new(requestJson['food']['data'])
    puts "**************Food coords*******************"
    puts requestJson['food']
    puts "*********************************"
    puts "**************keys*******************"
    puts requestJson.keys
    puts "*********************************"
    # Calculate a move with the request data

    # Dummy response
    puts "="* 50
    p snake.name, snake.available_moves, snake.body
    puts "="* 50
    direction = snake.available_moves.sample
    responseObject = {
      "move" => direction.to_s
    }

    p responseObject
    return responseObject.to_json
  end

  post '/end' do
    p :end
      requestBody = request.body.read
      requestJson = requestBody ? JSON.parse(requestBody) : {}

      p requestJson
      # No response required
      responseObject = {}

      return responseObject.to_json
  end
end
