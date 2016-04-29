# series.rb

# 1. transform the string to an array
# 2. calculate how many series there will be (e.g length minus n + 1)
# 3. create the sub-arrays in a loop and push tehm to the main array


class Series
  def initialize(string)
    @string = string
  end
  
  def slices(n)
    num_arr = @string.split('').map { |idx| idx.to_i }
    len = num_arr.length
    outer_arr = []
    counter = 0
    if n > len
      raise ArgumentError#, 'Can only add Todo objects'
    else 
      while counter < (len - n) + 1
        sub_arr = num_arr.slice(counter, n)
        outer_arr << sub_arr
        counter += 1
      end
    end
    outer_arr
  end
end
