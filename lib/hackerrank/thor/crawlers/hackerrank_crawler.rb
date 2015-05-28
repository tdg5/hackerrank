module Hackerrank::Thor::Crawlers
  class HackerrankCrawler
    HACKERRANK_URL = "https://www.hackerrank.com".freeze
    HACKERRANK_REST_URL = "#{HACKERRANK_URL}/rest/".freeze

    def challenge_get(path)
      get_json(path)
    end

    def url_html(path)
      html_path = path.gsub(/contests\/master\//, "")
      parse_uri(html_path).to_s
    end

    def url_json(path)
      parse_uri(path, :format => :json).to_s
    end

    private

    def get_json(path)
      parse_uri(path, :format => :json).read
    end

    def parse_uri(path, options = {})
      base_path = options[:format] == :json ? HACKERRANK_REST_URL : HACKERRANK_URL
      request_url = File.join(base_path, path)
      request_url.concat(".json") if options[:format] == :json
      URI.parse(request_url)
    end
  end
end
