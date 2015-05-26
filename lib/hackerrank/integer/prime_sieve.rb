module Hackerrank::Integer
  class PrimeSieve
    def initialize(options = {})
      opts = default_options.merge!(options)
      initial_size = opts[:initial_size]
      @maximum_size = opts.fetch(:maximum_size)
      @primes = [2]
      @offset = 2
      @sieve = Array.new(initial_size)
      @sieve[0] = true
      falsify_composites
    end

    def [](index)
      while index >= offset + size
        grow || shift
      end

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
          grow || shift
        end
      end
    end

    def size
      @sieve.length
    end

    private

    attr_reader :offset

    def default_options
      {
        :initial_size => 10_000,
        :maximum_size => 10_000_000,
      }
    end

    def falsify_composites
      known_primes = primes.dup
      min_new_prime_index = 0
      max_value = offset + size - 1
      previous_prime = 1
      max_sqrt = Math.sqrt(max_value)

      while known_primes.any?
        prime = known_primes.shift
        if prime <= max_sqrt
          min_value = (offset / prime.to_f).ceil * prime
          min_value.step(max_value, prime) do |composite|
            @sieve[composite - offset] = false
          end
        end
        previous_prime = prime

        next if known_primes.any?

        index = min_new_prime_index
        # Only traverse odd candidates
        index += 1 if (index + offset) % 2 == 0
        while index < size
          if @sieve[index].nil?
            @sieve[index] = true
            min_new_prime_index = index + 2
            new_prime = index + offset
            known_primes << new_prime
            @primes << new_prime
            break
          end
          index += 2
        end
      end
    end

    def grow
      return false if size == @maximum_size
      @offset += size
      new_size = [size * 2, @maximum_size].min

      @sieve.replace(Array.new(new_size))
      falsify_composites
      true
    end

    def primes
      @primes.dup
    end

    def shift
      @sieve.replace(Array.new(size))
      @offset += size
      falsify_composites
      true
    end
  end
end
