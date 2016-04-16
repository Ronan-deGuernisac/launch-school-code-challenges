# find_largest_product.rb

# Find the thirteen adjacent digits in the 1000-digit number that have the
# greatest product. What is the value of this product?
#
# Approach:
# 1. Need to iterate through the integer 9 digits at a time until there are no 9
# digit groupings remaining
# 2. For each group need to sum the group and compare it agains the sum of the 
# previous group keeping the group with the largest sum
# 3. Once all the groupings have been iterated need to return the grouping with 
# the largest sum and its sum

# def get_next_thirteen(arr, start_index)
#   arr.slice(start_index, 13)
# end

# def sum_array(arr)
#   sum = 0
#   arr.each { |num| sum += num }
#   sum
# end

# def find_best_thirteen(arr)
#   best_thirteen = get_next_thirteen(arr, 0)
#   idx = 1
#   next_thirteen = []
#   loop do
#     next_thirteen = get_next_thirteen(arr, idx)
#     break if next_thirteen.length < 13
#     best_thirteen = next_thirteen if sum_array(next_thirteen) > sum_array(best_thirteen)
#     idx += 1
#   end
#   best_thirteen
# end

def find_best_thirteen(num)
  arr = num.chars.reject { |number| number == "\n" }.map(&:to_i)
  best_thirteen = arr.slice(0, 13)
  arr.each_cons(13) do |next_thirteen|
    best_thirteen = next_thirteen if next_thirteen.reduce(:*) > best_thirteen.reduce(:*)
  end
  best_thirteen
end

num = "73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450"

# arr = num.chars.map(&:to_i)
# best_thirteen = find_best_thirteen(arr)
# best_thirteen_product = sum_array(best_thirteen)

puts "The thirteen consecutive digits with the highest product is #{find_best_thirteen(num)}."
puts "The product of those thirteen digits is #{find_best_thirteen(num).reduce(:*)}."
