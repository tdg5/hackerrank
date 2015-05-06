# Problem Statement
#
# Given an array A={a1,a2,…,aN} of N elements, find the maximum possible sum of
# a:
# - Contiguous subarray Non-contiguous (not necessarily contiguous) subarray.
# - Empty subarrays/subsequences should not be considered.
#
# This Youtube video by Ben Wright might be useful to understand the Kadane
# algorithm for the maximum subarray in a 1-D sequence.
#
# https://www.youtube.com/watch?v=EK71U-vTOt4
#
# Input Format
#
# First line of the input has an integer T. T cases follow.  Each test case
# begins with an integer N. In the next line, N integers follow representing the
# elements of array A.
#
# Constraints:
#
# 1 ≤ T ≤ 10
# 1 ≤ N ≤ 105
# −104 ≤ ai ≤ 104
#
# The subarray and subsequences you consider should have at least one element.
#
# Output Format
#
# Two, space separated, integers denoting the maximum contiguous and
# non-contiguous subarray. At least one integer should be selected and put into
# the subarrays (this may be required in cases where all elements are negative).
#
# Sample Input
#
# 2
# 4
# 1 2 3 4
# 6
# 2 -1 2 3 4 -5
#
# Sample Output
#
# 10 10
# 10 11
#
# Explanation
#
# In the first case: The max sum for both contiguous and non-contiguous elements
# is the sum of ALL the elements (as they are all positive).
#
# In the second case: [2 -1 2 3 4] --> This forms the contiguous sub-array with
# the maximum sum.  For the max sum of a not-necessarily-contiguous group of
# elements, simply add all the positive elements.

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
