# Problem Statement
#
# A strange grid has been recovered from an old book. It has 5 columns and
# infinite number of rows. The bottom row is considered as the first row. First
# few rows of the grid are like this:
#
# ..............
#
# ..............
#
# 20 22 24 26 28
#
# 11 13 15 17 19
#
# 10 12 14 16 18
#
#  1  3  5  7  9
#
#  0  2  4  6  8
#
# The grid grows upwards forever!
#
# Your task is to find the integer in cth column in rth row of the grid.
#
# Input Format
#
# There will be two integers r and c separated by a single space.
#
# Constraints
#
# 1 ≤ r ≤ 2 * 10 ** 9
#
# 1 ≤ c ≤ 5
#
# Rows are indexed from bottom to top and columns are indexed from left to right.
#
# Output Format
#
# Output the answer in a single line.
#
# Sample Input
#
# 6 3
#
# Sample Output
#
# 25
#
# Explanation
#
# The number in the 6th row and 3rd column is 25.

def main
  coord = gets.strip.split(" ").map!(&:to_i)
  puts self[coord.first - 1, coord.last - 1]
end

def [](row, col)
  (row / 2 * 2 * 5) + (col * 2) + (row % 2)
end

main
