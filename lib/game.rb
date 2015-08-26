class Game
  attr_reader :board
  attr_accessor :player1, :player2, :turn

  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
    @turn = 0
  end

  def get_names
    get_name_1
    get_name_2
  end

  def get_name_1
    print "What is Player 1's Name? "
    response = gets.chomp
    if response.length == 0
      puts "You must enter at least one character."
      get_name_1
    else
      @player1 = Player.new(response, "X")
    end
  end

  def get_name_2
    print "What is Player 2's Name? "
    response = gets.chomp
    if response == player1.name
      puts "Player names cannot be the same."
      puts "Please pick a different name for Player 2."
      get_name_2
    elsif response.length == 0
      puts "You must enter at least one character."
      get_name_2
    else
      @player2 = Player.new(response, "0")
    end
  end

  def current_player
    if @turn.even?
      player2
    else
      player1
    end
  end

  def move
    @turn += 1
    print "#{current_player.name}'s turn! [#{current_player.token}] "
    print "Which column do you choose (A-G)? "
    column = gets.chomp.downcase
    @board.drop(current_player.token, column)
    check_win
  end

  def check_win
    if @board.grid_array[0].include? "_"
      look_for_four
    else
      puts "Board is full! Stalemate! Thanks for playing."
    end
  end

  def look_for_four
    if  vertical_win || horizontal_win || diagonal_win
      puts "#{current_player.name} wins! Thanks for playing."
    else
      move
    end
  end

  private

  def grid
    @board.grid_array
  end

  def x_coord
    @board.last_coords[0]
  end

  def y_coord
    @board.last_coords[1]
  end

  def vertical_win
    count_up(grid, x_coord, y_coord) +
    count_down(grid, x_coord, y_coord) - 1 == 4
  end

  def horizontal_win
    count_left(grid, x_coord, y_coord) +
    count_right(grid, x_coord, y_coord) - 1 == 4
  end

  def diagonal_win
    forward_diagonal || backward_diagonal
  end

  def forward_diagonal
    sum_up_right(grid, x_coord, y_coord) + sum_down_left(grid, x_coord, y_coord) - 1 == 4
  end

  def backward_diagonal
    sum_down_right(grid, x_coord, y_coord) + sum_up_left(grid, x_coord, y_coord) - 1 == 4
  end

  def stop_counting?(grid, x, y)
    token = current_player.token
    out_of_bounds = false
    is_nil = false

    if x < 0 || x > 5 || y < 0 || y > 5
      out_of_bounds = true
    end

    if grid[x].nil? || grid[x][y].nil?
      is_nil = true
    end

    out_of_bounds || is_nil || grid[x][y] != token
  end

  def count_up(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += count_up(grid, x - 1, y)
  end

  def count_down(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += count_down(grid, x + 1, y)
  end

  def count_left(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += count_left(grid, x, y - 1)
  end

  def count_right(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += count_right(grid, x, y + 1)
  end

  def sum_up_left(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += sum_up_left(grid, x - 1, y - 1)
  end

  def sum_up_right(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += sum_up_right(grid, x - 1, y + 1)
  end

  def sum_down_left(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += sum_down_left(grid, x + 1, y - 1)
  end

  def sum_down_right(grid, x, y)
    if stop_counting?(grid, x, y)
      return 0
    end
    count = 1
    count += sum_down_right(grid, x + 1, y + 1)
  end
end
