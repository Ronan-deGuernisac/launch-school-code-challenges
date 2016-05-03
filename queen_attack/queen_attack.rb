# queen_attack.rb

class Queens # :nodoc:
  attr_reader :white, :black

  def initialize(queens = { white: [0, 3], black: [7, 3] })
    raise ArgumentError, 'Queens cannot occupy the same space' if
    queens[:white] == queens[:black]
    @white = queens[:white]
    @black = queens[:black]
    @board = Array.new(8) { Array.new(8, '_') }
    place_queens
  end

  def place_queens
    @board[white.first][white.last] = 'W'
    @board[black.first][black.last] = 'B'
  end

  def attack?
    same_row? || same_column? || same_diagonal?
  end

  def same_row?
    white.first == black.first
  end

  def same_column?
    white.last == black.last
  end

  def same_diagonal?
    (white.first - black.first).abs == (white.last - black.last).abs
  end

  def to_s
    @board.map { |line| line.join(' ') }.join("\n")
  end
end
