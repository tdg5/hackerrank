require "hackerrank/thor/crawlers/hackerrank_crawler"
require "hackerrank/thor/parsers/hackerrank_parser"

module Hackerrank::Thor::Presenters
  class ChallengePresenter
    DefaultCrawler = Hackerrank::Thor::Crawlers::HackerrankCrawler
    DefaultParser = Hackerrank::Thor::Parsers::HackerrankParser

    attr_reader :contest_slug, :description, :languages, :name, :slug, :url

    def default_crawler
      DefaultCrawler.new
    end

    def default_parser
      DefaultParser.new
    end

    def initialize(options = {})
      @path = options.fetch(:path)
      @crawler = options[:crawler] || default_crawler
      @parser = options[:parser] || default_parser
    end

    def challenge
      @challenge ||= fetch_challenge
    end

    def wrap_at_limit(line, limit = 80)
      wrapped_text = ""
      line_length = 0
      line.split(/ /m).each do |word|
        if line_length.zero?
          addition = word
          line_length += addition.length
        elsif line_length + word.length + 1 <= limit
          addition = " #{word}"
          line_length += addition.length
        else
          addition = "\n#{word}"
          line_length = word.length
        end
        wrapped_text.concat(addition)
      end
      wrapped_text
    end

    private

    attr_reader :crawler, :parser

    def fetch_challenge
      challenge_data = crawler.challenge_get(@path)
      attributes = parser.challenge_parse(challenge_data)
      attributes[:url] = crawler.url_html(@path)
      present(attributes)
      self
    end

    def present(attributes)
      @contest_slug = attributes[:contest_slug]
      @description = attributes[:description]
      @name = attributes[:name]
      @slug = attributes[:slug]
      @languages = attributes[:languages]
      @url = attributes[:url]
    end
  end
end
