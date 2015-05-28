require "json"

module Hackerrank::Thor::Parsers
  class HackerrankParser

    def challenge_parse(json)
      model = JSON.parse(json)["model"]
      description_data = challenge_body_parse(model["body"])
      {
        :contest_slug => model["contest_slug"],
        :description => description_data,
        :languages => model["languages"],
        :name => model["name"],
        :slug => model["slug"],
      }
    end

    private

    def challenge_body_parse(challenge_body)
      current_header = :problem_statement
      info = Hash.new { |h, k| h[k] = [] }
      challenge_body.split("\n").each do |line|
        line.strip!
        next if line.empty?

        case line
        when /^\*\*.*?\*\*$/
          header = line.scan(/(?:\*\*(.*?)\*\*)/).flatten.first
          current_header = header.downcase.gsub(/ /, "_").to_sym
        else
          info[current_header] << line
        end
      end
      sanitize_description_data(info)
      info
    end

    def sanitize_description_data(data)
      if data.key?(:problem_statement)
        sub_matcher = /<sub>.*?<\/sub>/
        data[:problem_statement].delete_if { |text| sub_matcher === text }
      end

      if data.key?(:constraints)
        le = /\\le/
        data[:constraints].each { |constraint| constraint.gsub!(le, "<=") }
      end
    end
  end
end
