require 'pathname'

module Pronto
  module Git
    class Patch < Struct.new(:patch, :repo)
      extend Forwardable

      def_delegators :patch, :delta, :hunks, :stat

      def additions
        stat[0]
      end

      def deletions
        stat[1]
      end

      def blame(lineno)
        repo.blame(self, lineno)
      end

      def lines
        @lines ||= begin
          hunks.map do |hunk|
            hunk.lines.map { |line| Line.new(line, self, hunk) }
          end.flatten.compact
        end
      end

      def added_lines
        lines.select(&:addition?)
      end

      def deleted_lines
        lines.select(&:deletion?)
      end

      def new_file_full_path
        repo_path = Pathname.new(repo.path).parent
        repo_path.join(delta.new_file[:path])
      end
    end
  end
end
