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
    puts "What is Player 1's Name?"
    @player1 = Player.new(gets.chomp, "X")
    check_name2(player1)
  end

  def check_name2(name1)
    puts "What is Player 2's Name?"
    name2 = gets.chomp
    if name1 == name2
      puts "Player names cannot be the same."
      puts "Please pick a different name for Player 2."
      check_name2(name1)
    else
      @player2 = Player.new(name2, "0")
    end
  end

  def move
    if @turn == 0
      current_player = player1
      @turn = 1
    else
      current_player = player2
      @turn = 0
    end
    print "#{current_player.name}'s turn! [#{current_player.token}] "
    print "Which column do you choose (A-G)? "
    column = gets.chomp.downcase
    @board.drop(current_player.token, column)
    check_win(current_player)
  end

  def current_player
    if @turn.
  end

  def check_win(player)
    if @board.grid_array[0].include? "_"
      look_for_four(player, @board.last_coords[0], @board.last_coords[1])
    else
      puts "Board is full! Stalemate! Thanks for playing."
    end
  end

  def look_for_four(player, x, y)
    token = player.token
    grid = @board.grid_array
    if  vertical_win(token, grid, x, y) || horizontal_win(token, grid, x, y) || diagonal_win(token, grid, x, y)
      puts "#{player.name} wins! Thanks for playing."
    else
      move
    end
  end

  private

  # This needs a TON of refactoring.
  # Wanted to get you a working version ASAP though. :)

  def vertical_win(token, grid, x, y)
    count_up(token, grid, x, y) + count_down(token, grid, x, y) - 1 == 4
  end

  def horizontal_win(token, grid, x, y)
    count_left(token, grid, x, y) + count_right(token, grid, x, y) - 1 == 4
  end

  def diagonal_win(token, grid, x, y)
    forward_diagonal(token, grid, x, y) || backward_diagonal(token, grid, x, y)
  end

  def forward_diagonal(token, grid, x, y)
    sum_up_right(token, grid, x, y) + sum_down_left(token, grid, x, y) - 1 == 4
  end

  def backward_diagonal(token, grid, x, y)
    sum_down_right(token, grid, x, y) + sum_up_left(token, grid, x, y) - 1 == 4
  end

  def stop_counting?(token, grid, x, y)
    out_of_bounds = false
    if x < 0 || x > 5 || y < 0 || y > 5
      out_of_bounds = true
    end

    out_of_bounds || grid[x].nil? || grid[x][y].nil? || grid[x][y] != token
  end

  def count_up(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += count_up(token, grid, x - 1, y)
  end

  def count_down(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += count_down(token, grid, x + 1, y)
  end

  def count_left(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += count_left(token, grid, x, y - 1)
  end

  def count_right(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += count_right(token, grid, x, y + 1)
  end

  def sum_up_left(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += sum_up_left(token, grid, x - 1, y - 1)
  end

  def sum_up_right(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += sum_up_right(token, grid, x - 1, y + 1)
  end

  def sum_down_left(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += sum_down_left(token, grid, x + 1, y - 1)
  end

  def sum_down_right(token, grid, x, y)
    if stop_counting?(token, grid, x, y)
      return 0
    end
    count = 1
    count += sum_down_right(token, grid, x + 1, y + 1)
  end
end
