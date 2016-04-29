# series.rb

# 1. transform the string to an array
# 2. calculate how many series there will be (e.g length minus n + 1)
# 3. create the sub-arrays in a loop and push them to the main array

class Series # :nodoc:
  def initialize(string)
    @number_array = to_num_array(string)
    @length = @number_array.length
  end

  def slices(n)
    if n > @length
      raise ArgumentError, "Requested series of length #{n} but string only of
      length #{@length}"
    else
      outer_array = sub_array_loop(n)
    end
    outer_array
  end

  private

  def sub_array_loop(n)
    outer_arr = []
    counter = 0
    while counter < (@length - n) + 1
      outer_arr << @number_array.slice(counter, n)
      counter += 1
    end
    outer_arr
  end

  def to_num_array(string)
    string.split('').map(&:to_i)
  end
end
