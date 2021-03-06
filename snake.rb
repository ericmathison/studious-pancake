class Game
  MOVES = %i|up down left right|
  MOVE_APPLICATIONS = {
    up: [:y, -1],
    down: [:y, 1],
    left: [:x, -1],
    right: [:x, 1],
  }
end

class FoodItems
  def initialize(food_coordinates)
    @first_food_item = food_coordinates.first
    @second_food_item = food_coordinates[1]
    @third_food_item = food_coordinates.last
  end
end

class Snake
  attr_reader :name, :length, :health, :id, :body
  def initialize(object)
    @name, @length, @health = object["name"], object["length"], object["health"]
    @id =object["id"]
    @body = if object["body"]["object"] == "list"
      object["body"]["data"]
    else
      object["body"]
    end
    puts "+++++++++++++++++++++++++++++++++++++++++++++"
    puts object
    puts "+++++++++++++++++++++++++++++++++++++++++++++"
  end

  # TODO: this needs some work
  def available_moves
    Game::MOVES.select do |direction|
      can_move?(direction)
    end
  end

  def find_food

  end

  def can_move?(direction)
    coordinates_would_be = calculate(direction)
    # puts "checking for #{direction}, #{coordinates_would_be}"
    return false if out_of_bounds?(coordinates_would_be)
    !body.include?(coordinates_would_be)
  end

  def head
    @body.first
  end

  def calculate(direction)
    axis, application = Game::MOVE_APPLICATIONS[direction]
    next_coords = head.clone
    next_coords[axis.to_s] = next_coords[axis.to_s] + application
    next_coords
  end

  def out_of_bounds?(coords)
    return true unless (0..14).include?(coords['x']) && (0..14).include?(coords['y'])
    false
  end
end
