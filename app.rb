require 'bundler'
Bundler.require

$LOAD_PATH.unshift(__dir__)
$LOAD_PATH.unshift( File.expand_path('lib/app', __dir__) )
$LOAD_PATH.unshift( File.expand_path('lib/class', __dir__) )
$LOAD_PATH.unshift( File.expand_path('lib/view', __dir__) )

require 'game'
require 'show'

def ask_name(player)
  puts "Entre le nom du #{player}"
  print ">"
  gets.chomp
end

def ask_symbol
  puts "Entre son symbole"
  print ">"
  gets.chomp
end

def perform
  my_game = nil
  loop do
    my_game = Game.fabricate([ask_name("joueur 1"), ask_symbol], [ask_name("joueur 2"), ask_symbol])
    break if my_game.kind_of? Game
    puts my_game
  end
  my_game.play

end

perform