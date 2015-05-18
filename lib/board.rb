  class Board
    attr_reader :board, :empty_cell

    def initialize
      @empty_cell = '-'
      @board = Array.new(9, @empty_cell)
    end

    def print_grid
      puts "\n"
      @board.each_slice(3) { |row| puts row.join(' | ') }
      puts "\n"
    end

    def update(pos, sym)
      if @board[pos] == @empty_cell
        @board[pos] = sym
        return true
      else
        return false
      end
    end
  end
