class Board
  attr_reader :grid_array, :last_coords
  def initialize
    @grid_array = Array.new(6) { Array.new(7, "_") }
    @last_coords = [nil, nil]
  end

  def display
    @grid_array.each do |row|
      print "|"
        row.each do |tile|
          print " #{tile} "
        end
       puts "|"
    end
    puts "| A  B  C  D  E  F  G |"
  end

  def drop(token, column)
    y = convert(column)
    if y == "error" || @grid_array[0][y] != "_"
      print "You cannot place a token there. Choose a different column (A-G): "
      column = gets.chomp
      drop(token, column)
    else
      x = find_x(y)
      @grid_array[x][y] = token
      display
      @last_coords = [x, y]
    end
  end

  private

  def convert(column)
    if column == "a"
      0
    elsif column == "b"
      1
    elsif column == "c"
      2
    elsif column == "d"
      3
    elsif column == "e"
      4
    elsif column == "f"
      5
    elsif column == "g"
      6
    else
      "error"
    end
  end

  def find_x(y)
    if @grid_array[5][y] == "_"
      5
    elsif @grid_array[4][y] == "_"
      4
    elsif @grid_array[3][y] == "_"
      3
    elsif @grid_array[2][y] == "_"
      2
    elsif @grid_array[1][y] == "_"
      1
    else
      0
    end
  end
end
