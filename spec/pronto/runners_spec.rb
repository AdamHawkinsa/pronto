module Pronto
  describe Runners do
    describe '#run' do
      subject { described_class.new(runners, config).run(patches) }
      let(:patches) { double(commit: nil, any?: true) }
      let(:config) { Config.new }

      context 'no runners' do
        let(:runners) { [] }
        it { should be_empty }
      end

      context 'fake runner' do
        class FakeRunner
          def run(_, _)
            [1, nil, [3]]
          end
        end

        let(:runners) { [FakeRunner] }
        it { should == [1, 3] }

        context 'rejects excluded files' do
          let(:config) { double(excluded_files: ['1']) }
          let(:patches) { [double(new_file_full_path: 1)] }
          it { should be_empty }
        end

        context 'max warnings' do
          let(:config) { double(max_warnings: 1, excluded_files: []) }
          it { should == [1] }
        end
      end
    end
  end
end
