module Pronto
  class Runners
    def initialize(runners = Runner.runners, config = Config.new)
      @runners = runners
      @config = config
    end

    def run(patches)
      patches = reject_excluded(patches)
      return [] unless patches.any?

      result = []
      @runners.each do |runner|
        next if @config.max_warnings && result.count >= @config.max_warnings
        result += runner.new.run(patches, patches.commit).flatten.compact
      end
      result = result.take(@config.max_warnings) if @config.max_warnings
      result
    end

    private

    def reject_excluded(patches)
      return patches unless @config.excluded_files.any?
      patches.reject! { |patch| excluded?(patch) }
      patches
    end

    def excluded?(patch)
      @config.excluded_files.include?(patch.new_file_full_path.to_s)
    end
  end
end
