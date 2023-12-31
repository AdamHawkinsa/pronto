module Pronto
  module Formatter
    class BitbucketServerPullRequestFormatter < PullRequestFormatter
      def self.name
        'bitbucket_server_pr'
      end

      def client_module
        BitbucketServer
      end

      def pretty_name
        'BitBucket Server'
      end

      def line_number(message, _)
        message.line.line.new_lineno if message.line
      end
    end
  end
end

Pronto::Formatter.register(Pronto::Formatter::BitbucketServerPullRequestFormatter)
