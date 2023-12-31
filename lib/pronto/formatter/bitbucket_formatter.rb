module Pronto
  module Formatter
    class BitbucketFormatter < CommitFormatter
      def self.name
        'bitbucket'
      end

      def client_module
        Bitbucket
      end

      def pretty_name
        'BitBucket'
      end

      def line_number(message, _)
        message.line.new_lineno if message.line
      end
    end
  end
end

Pronto::Formatter.register(Pronto::Formatter::BitbucketFormatter)
