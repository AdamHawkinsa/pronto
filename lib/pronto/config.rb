module Pronto
  class Config
    def initialize(config_hash = ConfigFile.new.to_h)
      @config_hash = config_hash
    end

    %w(github gitlab).each do |service|
      ConfigFile::EMPTY[service].each do |key, _|
        name = "#{service}_#{key}"
        define_method(name) { ENV[name.upcase] || @config_hash[service][key] }
      end
    end

    def excluded_files
      @excluded_files ||= exclude.flat_map { |path| Dir[path] }
    end

    def github_hostname
      URI.parse(github_web_endpoint).host
    end

    private

    def exclude
      @config_hash['all']['exclude']
    end
  end
end
