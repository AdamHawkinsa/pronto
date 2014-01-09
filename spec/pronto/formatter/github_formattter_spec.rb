require 'spec_helper'
require 'ostruct'

module Pronto
  module Formatter
    describe GithubFormatter do
      let(:github_formatter) { GithubFormatter.new }
      let(:repository) { Rugged::Repository.init_at('.') }

      describe '#format' do
        subject { github_formatter.format(messages) }
        let(:messages) { [message, message] }
        let(:message) { Message.new('path/to', line, :warning, 'crucial') }
        let(:line) { OpenStruct.new({new_lineno: 1}) }

        before { message.stub(:repo).and_return(repository) }
        specify do
          Octokit::Client.any_instance
                         .should_receive(:create_commit_comment)
                         .twice
          subject
        end
      end
    end
  end
end
