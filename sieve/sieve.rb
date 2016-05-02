# sieve.rb

class Sieve # :nodoc:
  def initialize(upper_limit)
    @range  = (2..upper_limit).to_a
  end

  def primes
    @range.each do |number| 
      if number.class == Fixnum
        @range.map! do |num| 
          if num != number && num % number == 0
            num = num.to_s 
          else
            num = num
          end
        end
      end
    end
    @range.reject! { |item| item.class == String }
  end
end
