# beer_song.rb

class BeerSong # :nodoc:
  def verse(bottles)
    if bottles == 0
      <<-VERSE
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
    VERSE
    elsif bottles == 1
      <<-VERSE
1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
    VERSE
    elsif bottles == 2
      <<-VERSE
2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.
    VERSE
    else
      <<-VERSE
#{bottles} bottles of beer on the wall, #{bottles} bottles of beer.
Take one down and pass it around, #{bottles - 1} bottles of beer on the wall.
VERSE
    end
  end

  def verses(start, finish)
    bottles = [*finish..start].reverse
    bottles.map { |bottle| verse(bottle) }.join("\n")
  end

  def lyrics
    verses(99, 0)
  end
end
