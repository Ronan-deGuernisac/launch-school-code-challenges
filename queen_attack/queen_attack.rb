# queen_attack.rb

class Queens # :nodoc:
  attr_reader :white, :black

  def initialize(queens = { white: [0, 3], black: [7, 3] })
    raise ArgumentError, 'Queens cannot occupy the same space' if
    queens[:white] == queens[:black]
    @white = queens[:white]
    @black = queens[:black]
  end

  def attack?
    return true if same_row?
    return true if same_column?
    return true if same_diagonal?
    false
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
    board = [
['_', '_', '_', '_', '_', '_', '_', '_'],
['_', '_', '_', '_', '_', '_', '_', '_'],
['_', '_', '_', '_', '_', '_', '_', '_'],
['_', '_', '_', '_', '_', '_', '_', '_'],
['_', '_', '_', '_', '_', '_', '_', '_'],
['_', '_', '_', '_', '_', '_', '_', '_'],
['_', '_', '_', '_', '_', '_', '_', '_'],
['_', '_', '_', '_', '_', '_', '_', '_'],
]
    board[white.first][white.last] = 'W'
    board[black.first][black.last] = 'B'
    board.map! { |line| line.join(' ') }
    board.join("\n")
  end
end
