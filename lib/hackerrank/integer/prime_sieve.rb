module Hackerrank::Integer
  class PrimeSieve
    def initialize(options = {})
      opts = default_options.merge!(options)
      initial_size = opts[:initial_size]
      @maximum_size = opts.fetch(:maximum_size)
      @primes = [ 2 ]
      @offset = 3
      initialize_sieve(initial_size)
    end

    def [](index)
      resume while index >= offset + size

      return @primes.include?(index)
    end

    def each_prime
      return to_enum(__method__) unless block_given?

      index = 0
      loop do
        if @primes.length > index
          yield @primes[index]
          index += 1
        else
          resume
        end
      end
    end

    def capacity
      size * 2
    end

    def size
      @sieve.length
    end

    private

    attr_reader :offset

    def default_options
      {
        :initial_size => 1000,
        :maximum_size => 10_000_000,
      }
    end

    def falsify_composites
      applicable_primes = primes.dup
      # Drop 2
      applicable_primes.shift
      index = 0
      max_value = offset + capacity - 1
      max_sqrt = Math.sqrt(max_value)

      while index < size
        while applicable_primes.any?
          prime = applicable_primes.shift
          break if prime > max_sqrt

          min_value = (offset / prime.to_f).ceil * prime
          min_value += prime if min_value.even?
          min_value.step(max_value, prime * 2) do |composite|
            @sieve[(composite - offset) / 2] = false
          end
        end

        while applicable_primes.none? && index < size
          index += 1 and next unless @sieve[index]

          new_prime = index * 2 + offset
          applicable_primes << new_prime
          @primes << new_prime
          index += 1
          break
        end
      end
    end

    def grow
      return false if size == @maximum_size
      @offset += capacity
      initialize_sieve([capacity, @maximum_size].min)
    end

    def initialize_sieve(new_size = size)
      @sieve = Array.new(new_size, true)
      falsify_composites
      true
    end

    def primes
      @primes.dup
    end

    def resume
      @primes.last > capacity && grow || shift
    end

    def shift
      @offset += capacity
      initialize_sieve
    end
  end
end
