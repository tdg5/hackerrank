module Hackerrank::Integer
  class PrimeSieve
    def initialize(options = {})
      opts = default_options.merge!(options)
      @size = opts[:initial_size]
      @maximum_size = opts.fetch(:maximum_size)
      @primes = [ 2 ]
      @offset = 3
      @sieve = Array.new(@size, true)
      initialize_sieve
    end

    def [](index)
      resume while index >= offset + capacity
      @primes.include?(index)
    end

    def each_prime
      return to_enum(__method__) unless block_given?

      index = 0
      while true
        if @primes.length > index
          yield @primes[index]
          index += 1
        else
          resume
        end
      end
    end

    private

    attr_reader :capacity, :offset, :size

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
      @size = new_size
      @capacity = @size * 2
      @sieve.fill(true, 0, @size)
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
