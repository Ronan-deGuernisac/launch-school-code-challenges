# sieve.rb

class Sieve # :nodoc:
  def initialize(upper_limit)
    @sieve = {}
    (2..upper_limit).each { |number| @sieve[number] = nil }
  end

  def primes
    @sieve.each { |number, mark| mark_multiples(number) if mark.nil? }
    @sieve.reject { |_, mark| mark == 'Composite' }.keys
  end

  def mark_multiples(prime)
    @sieve.each do |number, _|
      @sieve[number] = 'Composite' if multiple?(number, prime)
    end
  end

  def multiple?(num, prime)
    num > prime && num % prime == 0
  end
end
