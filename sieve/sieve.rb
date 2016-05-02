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
    @sieve.select { |key, _| key > prime }.each do |number, _|
      @sieve[number] = 'Composite' if number % prime == 0
    end
  end
end
