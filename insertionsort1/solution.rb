def i_sort(argv)
  return if argv.length <= 1 || argv[-1] >= argv[-2]

  subject = argv.pop
  index = argv.length - 1
  while argv[index] > subject && index >= 0
    argv[index + 1] = argv[index]
    puts argv.join(" ")
    index -= 1
  end
  argv[index + 1] = subject
  puts argv.join(" ")
end

def main
  _argc = gets
  argv = gets.strip.split(" ").map(&:to_i).compact
  i_sort(argv)
end

main
