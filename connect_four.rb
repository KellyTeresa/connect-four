Dir[File.join('lib', '**', '*.rb')].each do |file|
  require_relative file
end

def play
  # good abstraction here. It might be nice to see if you could abstract all your `puts` statements into this method.
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
    # rather than recursively calling a method here. I might just create a while loop that keeps running the game from the start until the user no longer want's to 'restart' games.
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
