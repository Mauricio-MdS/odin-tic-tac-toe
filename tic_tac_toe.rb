# frozen_string_literal: true

# Two-player game of tic-tac-toe
class Game
  SEPARATOR = '---+---+---'
  WINNING_LINES = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # horizontal lines
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # vertical lines
    [0, 4, 8], [2, 4, 6]             # diagonal lines
  ].freeze

  def initialize
    @board = Array.new(9)
    @end_game = false
  end

  def play
    draw_board
    play_round until @end_game
  end

  private

  def board_line(line_number)
    start_index = line_number * 3
    line_values = @board[start_index, 3].map.with_index { |value, index| value || (start_index + index + 1) }
    " #{line_values.join(' | ')} "
  end

  def check_end
    WINNING_LINES.each do |line|
      moves = line.map { |index| @board[index] }
      return victory if moves.all?('X') || moves.all?('O')
    end
    draw if @board.compact.size == 9
  end

  def current_player
    @board.compact.size.even? ? 'X' : 'O'
  end

  def draw
    puts 'Game ended with a draw!'
    @end_game = true
  end

  def draw_board
    puts
    0.upto(2) do |line|
      puts board_line(line)
      puts line == 2 ? '' : SEPARATOR
    end
  end

  def last_player
    @board.compact.size.even? ? 'O' : 'X'
  end

  def make_move
    loop do
      puts "Player #{current_player}, choose an avaiable number(1-9):"
      move = gets.to_i
      if move.between?(1, 9) && !@board[move - 1]
        @board[move - 1] = current_player
        return
      else
        puts 'Invalid option'
      end
    end
  end

  def play_round
    make_move
    draw_board
    check_end
  end

  def victory
    puts "Player #{last_player} won!"
    @end_game = true
  end
end

game = Game.new
game.play
