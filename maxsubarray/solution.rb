def main
  test_case_count = gets.to_i
  test_cases = []
  test_case_count.times do
    _argc = gets
    test_cases << gets.strip.split(" ").map!(&:to_i)
  end

  test_cases.each do |test_case|
    puts "#{max_contig(test_case)} #{max_non_contig(test_case)}"
  end
end

# Remove all negatives
def max_non_contig(argv)
  sum = index = 0
  found_something = false
  while index < argv.length
    value = argv[index]
    if value > 0
      found_something = true
      sum += value
    end
    index += 1
  end
  found_something ? sum : argv.max
end

def max_contig(argv)
  max = -Float::INFINITY
  start = finish = 0
  argc = argv.length
  while start < argc
    finish = start
    sum = 0
    while finish < argc
      sum += argv[finish]
      finish += 1
      max = sum if sum > max
    end
    start += 1
  end
  max
end

main
