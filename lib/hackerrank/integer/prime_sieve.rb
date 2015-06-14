module Hackerrank::Integer
  class PrimeSieve
    def initialize(options = {})
      opts = default_options.merge!(options)
      @size = opts[:initial_size]
      @maximum_size = opts.fetch(:maximum_size)
      @primes = [ 2 ]
      @offset = 3
      @can_grow = true
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
        resume while @primes.length <= index
        yield @primes[index]
        index += 1
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
      # Drop 2
      prime_index = 1
      index = 0
      max_value = offset + capacity - 1
      max_transposed = ((max_value - offset) / 2.0).ceil
      max_sqrt = Math.sqrt(max_value).to_i
      # Exiting state needed to gather uncollected primes
      traversal_in_progress = true
      offset_f = offset.to_f
      half_offset = offset / 2

      while index < size
        index_f = index * 2 + offset_f
        while prime = @primes[prime_index]
          break(traversal_in_progress = false) if prime > max_sqrt
          prime_index += 1

          # index_f / prime yields nearest multiple in range. We take the ceil
          # of this because we want the first one in the range, not the last one
          # before the range. If we round down, sometimes we won't be able to
          # distinguish what's in the range and what's before it. If we round
          # up, we always know it's in the range. We then OR with 1 to ensure
          # it's the first odd multiple in the range.
          multiplier = (index_f / prime).ceil - 2 | 1
          composite = prime * multiplier / 2
          transposed = composite - half_offset
          @sieve[transposed] = false while (transposed += prime) < max_transposed
        end

        while index < size
          next(index += 1) unless @sieve[index]
          @primes << index * 2 + offset
          index += 1
          break if traversal_in_progress
        end
      end
    end

    def grow
      return(@can_grow = false) if size == @maximum_size
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
      @can_grow ? grow : shift
    end

    def shift
      @offset += capacity
      initialize_sieve
    end
  end
end
