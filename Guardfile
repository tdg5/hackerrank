guard(:minitest, :all_after_pass => false, :all_on_start => false) do
  watch(%r{^lib/hackerrank\.rb$}) { "test" }
  watch(%r{^lib/hackerrank/(.+)\.rb$}) { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^lib/hackerrank/solutions/(.+)/(.+)\.rb$}) do |m|
    Dir["test/integration/solutions/#{m[1]}/*_test.rb"]
  end
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { "test" }
end

