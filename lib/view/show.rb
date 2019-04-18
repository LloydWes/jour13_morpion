class Show
  def self.display_board(board)
    # puts "Affichage"
    print " ", "_" * 5, "\n"
    board.each do |row|
      print "|"
      row.each do |cell|
        if cell.is_full?
          print cell.value,"|"
        else
          print " ", "|"
        end
      end
      puts ""
    end
    print " ", "-" * 5, "\n"
  end
end