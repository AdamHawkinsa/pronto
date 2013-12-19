require 'spec_helper'

module Pronto
  describe Runner do
    let(:runner) { Runner.new }

    describe '#ruby_file?' do
      subject { runner.ruby_file?(path) }

      context 'ending with .rb' do
        let(:path) { 'test.rb' }
        it { should be_true }
      end

      context 'ending with .rb in directory' do
        let(:path) { 'amazing/test.rb' }
        it { should be_true }
      end

      context 'executable' do
        let(:path) { 'test' }
        before { File.stub(:open).with(path).and_return{shebang} }

        context 'ruby' do
          let(:shebang) { '#!ruby' }
          it { should be_true }
        end

        context 'bash' do
          let(:shebang) { '#! bash' }
          it { should be_false }
        end
      end
    end
  end
end
