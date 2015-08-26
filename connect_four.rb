Dir[File.join('lib', '**', '*.rb')].each do |file|
  require_relative file
end

def play
  puts "Welcome to Connect Four!"
  game = Game.new
  game.get_names
  puts "Beginning game between #{game.player1} and #{game.player2}:"
  game.board.display
  game.move
end

def restart?
  print "Play again? (Y/N) "
  answer = gets.chomp.downcase

  if answer == "y"
    initiate_game
  elsif answer == "n"
    puts "Ok, bye!"
  else
    puts "That is not a valid response."
    restart?
  end
end

def initiate_game
  play

  restart?
end

initiate_game
