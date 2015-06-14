if ENV["CI"]
  require "simplecov"
  require "coveralls"
  Coveralls.wear!
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.root(File.expand_path("../..", __FILE__))
end

require "minitest/autorun"
require "mocha/setup"

# Use alternate shoulda-style DSL for tests
module Hackerrank
  module Test
    class TestCase < Minitest::Spec
      class << self
        alias :setup :before
        alias :teardown :after
        alias :context :describe
        alias :should :it
      end
    end

    module Integration
      module Solutions
      end
    end

    module Unit
    end
  end
end

def ruby_prof(name = Time.now.to_f.round(2).to_s, &block)
  require "ruby-prof"
  #RubyProf.measure_mode = RubyProf::CPU_TIME
  result = RubyProf.profile(&block)
  printer = RubyProf::GraphHtmlPrinter.new(result)
  File.open("#{name}.html", "w") { |file| printer.print(file) }
end

def memory_profile(name = Time.now.to_f.round(2).to_s, &block)
  require "memory_profiler"
  report = MemoryProfiler.report(&block)
  File.open("#{name}-memory.txt", "w") { |file| report.pretty_print(file) }
end

def xshould(*); end
