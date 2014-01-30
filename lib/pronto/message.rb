module Pronto
  class Message
    attr_reader :path, :line, :level, :msg, :commit_sha

    LEVELS = [:info, :warning, :error, :fatal]

    def initialize(path, line, level, msg, commit_sha = nil)
      unless LEVELS.include?(level)
        raise ::ArgumentError, "level should be set to one of #{LEVELS}"
      end

      @path = path
      @line = line
      @level = level
      @msg = msg
      @commit_sha = commit_sha
      @commit_sha ||= line.commit_sha if line
    end

    def repo
      line.patch.delta.repo
    end
  end
end
