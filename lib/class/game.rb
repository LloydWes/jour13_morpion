require 'player'
require 'board'
require 'show'
class Game
  attr_reader :player1, :player2, :board, :number_of_plays, :winner

  def initialize(player1_info, player2_info)
    @player1 = Player.new(player1_info[0], player1_info[1])
    @player2 = Player.new(player2_info[0], player2_info[1])
    @board = Board.new
    @number_of_plays = 0
  end

  def self.fabricate(player1_info, player2_info)
    if player1_info[1] == player2_info[1]
      return "Erreur : Vous avez entré le même symbole pour les 2 joueurs"
    elsif player1_info[0] == player2_info[0]
      return "Erreur : Vous avez entré le même nom pour les 2 joueurs"
    elsif player1_info[1].length > 1 || player2_info[1].length > 1
      return "Erreur : Vous avez entré un symbole de plus d'un  pour au moins un joueurcaractère"
    elsif player1_info[1].length == 0 || player2_info[1].length == 0
      return "Erreur : Vous n'avez pas entré de symbole pour au moins un joueur"
    else
      new(player1_info, player2_info)
    end
  end

  def play
    entry = nil
    puts "La partie commence !"
    Show.display_board(@board.board)
    while(is_still_ongoing?)
      # puts "while"
      if is_still_ongoing?
        send_move(get_entry(@player1), @player1)
        @number_of_plays += 1
        Show.display_board(@board.board)
      end
      if is_still_ongoing?
        send_move(get_entry(@player2), @player2)
        @number_of_plays += 1
        Show.display_board(@board.board)
      end
    end # end while loop
    if !game_is_draw?
      claim_winner(winner)
    else
      puts "Egalité !" 
    end
    puts "Fin de la partie !"
  end #Fin méthode
  def get_entry(player)
    entry = nil
    loop do
      puts "#{player.name} à toi de jouer (ton symbole est le #{player.symbol}) (ex : a1 ou A1 ou B1)"
      print ">"
      entry = gets.chomp
      break if valid_entry?(entry)
      puts "Erreur : Entrée invalide (déso) retente le coup"
    end #Fin loop
    return entry
  end #Fin méthode
  def valid_entry?(entry)
    if entry.kind_of? String
      entry.downcase!
      if entry.length == 2
        case entry[0]
        when 'a', 'b','c' #Je vérifie que le premier caractère est bien une lettre (a,b ou c)
          case entry[1]
          when '1','2','3' #Je vérifie que le second caractère est bien un "chiffre" (1,2 ou 3)
            return true
          end
        end
      end
    end
    return false
  end # Fin méthode
  def send_move(entry, player)
    loop do
      break if @board.fill_case(entry, player.symbol)
      puts "Erreur : La case dans laquelle tu veux jouer est déjà prise, retente le coup"
      entry = get_entry(player)
    end #Fin loop
  end #Fin méthode
  def is_still_ongoing?
    !one_player_won? && !game_is_draw?
  end

  def one_player_won?
    return same_symbol_on_line? || same_symbol_on_column? || same_symbol_on_diag?
  end

  def same_symbol_on_line?()
    check_same_symbol_on_line(@board.board)
  end #Fin méthode
  def check_same_symbol_on_line(array)
    local_board = array
    full_of_same = true
    first_symbol = ""
    local_board.each do |row|
      first_symbol = row.first.value
      row.each do |cell|
        if (cell.value != first_symbol) && cell.is_full?
          full_of_same = false
          break
        elsif cell.is_empty?
          full_of_same =false
          break
        end
      end #end row
      if full_of_same
        get_player_with_symbol(first_symbol)
        return true
      end
      full_of_same = true
    end #End local_board
    return false
  end
  def same_symbol_on_column?()
    check_same_symbol_on_line(@board.rotate_board)
  end
  def same_symbol_on_diag?
    local_board = @board.board
    full_of_same = true
    first_symbol = ""
    (0..2).each do |current|
      first_symbol = local_board.first.first.value
      if (local_board[current][current].value != first_symbol) && local_board[current][current].is_full?
        full_of_same = false
        break
      elsif local_board[current][current].is_empty?
        full_of_same = false
        break
      end
      full_of_same = true
    end #generale loop
    if full_of_same
      get_player_with_symbol(first_symbol)
      return true
    end
    last_symbol = local_board.first.last.value
    2.downto(0) do |current|
      if (local_board[current][2-current].value != last_symbol) && local_board[current][2-current].is_full?
        full_of_same = false
        break
      elsif local_board[current][2-current].is_empty?
        full_of_same = false
        break
      end
      # end # end imbriqué
      full_of_same = true
    end #generale loop
    if full_of_same
      get_player_with_symbol(last_symbol)
      return true
    end
    return false
  end
  def game_is_draw?
    @number_of_plays >= 9
  end
  def get_player_with_symbol(symbol)
    @winner = player1 if player1.symbol == symbol
    @winner = player2 if player2.symbol == symbol
  end
  def claim_winner(winner)
    puts "Hip hip hip hourra ! #{winner.name} gagne la partie !"
  end
end