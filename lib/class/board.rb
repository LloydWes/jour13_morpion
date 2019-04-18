
$LOAD_PATH.unshift(__dir__)
$LOAD_PATH.unshift( File.expand_path('lib/app', __dir__) )
$LOAD_PATH.unshift( File.expand_path('lib/class', __dir__) )
$LOAD_PATH.unshift( File.expand_path('view', __dir__) )

require 'board_case'
require 'pry'
class Board
  attr_accessor :board, :board_column

  def initialize
    @board = Array.new
    (1..3).each do |n|
      @board << make_cells_array
    end
  end
  def make_cells_array
    temp_array = Array.new
    (1..3).each do |n|
      temp_array << BoardCase.new 
    end
    temp_array
  end

  def board #Retourne le plateau de jeu pour l'affichage
    @board
  end

  def fill_case(cell, symbol)
    row = cell[0].ord%96 - 1
    column = cell[1].to_i - 1
    # binding.pry
    if @board[row][column].is_empty?
      @board[row][column].fill(symbol)
    else
      return false
    end
  end

  def rotate_board
    # puts "rotate !"
    new_board = Array.new
    3.times do
      new_board << Array.new(3)
    end
    intermediaire = nil
    # puts "avant prmière boucle"
    (0...@board.length).each do |i|
      (0...@board.length).each do |j|
        new_board[i][j] = @board[@board.length - j - 1][i]
      end
    end
# p new_board
    # puts "rotate done!"
    return new_board
  end
end

  # for (int i = 0; i < n; ++i) {
  #       for (int j = 0; j < n; ++j) {
  #           ret[i, j] = matrix[n - j - 1, i];
  #       }
  #   }





# bd = Board.new
# puts bd.class
# puts bd.board.length