require "hackerrank/thor/presenters/solution_presenter"

module Hackerrank
  module Generate
    class Solution < ::Thor::Group
      include ::Thor::Actions
      SolutionPresenter = Hackerrank::Thor::Presenters::SolutionPresenter

      argument :path
      argument :name

      def self.destination_root
        File.expand_path("../../..", __FILE__)
      end

      def self.source_root
        File.expand_path("../..", __FILE__)
      end

      def create_lib_file
        src = "templates/solution.rb.erb"
        template(src, presenter.solution_source_path)
      end

      def create_readme_file
        src = "templates/README.md.erb"
        template(src, presenter.solution_readme_path)
      end

      def create_test_file
        src = "templates/solution_test.rb.erb"
        template(src, presenter.solution_test_path)
      end

      def presenter
        @presenter ||= SolutionPresenter.new({
          :challenge_path => path,
          :name => name,
        })
      end
    end
  end
end
