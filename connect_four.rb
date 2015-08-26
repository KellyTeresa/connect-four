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

play
