
$LOAD_PATH.unshift(__dir__)
$LOAD_PATH.unshift( File.expand_path('lib/app', __dir__) )
$LOAD_PATH.unshift( File.expand_path('lib/class', __dir__) )
$LOAD_PATH.unshift( File.expand_path('view', __dir__) )

require 'board_case'
require 'pry'
class Board
  attr_accessor :board

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
  #Remplir une case (si elle est vide)
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
  #Retourne une version du tableau qui est tournée de 90° vers la droite, les colonnes deviennent des lignes
  def rotate_board
    new_board = Array.new
    3.times do
      new_board << Array.new(3)
    end
    intermediaire = nil
    (0...@board.length).each do |i|
      (0...@board.length).each do |j|
        new_board[i][j] = @board[@board.length - j - 1][i]
      end
    end
    return new_board
  end
end

