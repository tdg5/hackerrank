require "hackerrank/thor/presenters/challenge_presenter"

module Hackerrank::Thor::Presenters
  class SolutionPresenter
    DefaultChallengePresenter = Hackerrank::Thor::Presenters::ChallengePresenter

    attr_reader :name, :path

    def initialize(options = {})
      @path = options.fetch(:challenge_path)
      @name = options[:name] || File.basename(@path)
      @challenge_presenter = options[:challenge_presenter] || default_challenge_presenter
    end

    def challenge
      @challenge_presenter.challenge
    end

    def default_challenge_presenter
      DefaultChallengePresenter.new({
        :path => path,
      })
    end

    def module_name
      @module_name ||= name.capitalize
    end

    def solution_path
      "lib/hackerrank/solutions/#{name}"
    end

    def solution_readme_path
      File.join(solution_path, "README.md")
    end

    def solution_source_path
      File.join(solution_path, "solution.rb")
    end

    def solution_test_path
      "test/integration/solutions/#{name}/solution_test.rb"
    end

    def solution_require_path
      solution_path.gsub(/(^lib\/|\.rb$)/, '')
    end
  end
end
