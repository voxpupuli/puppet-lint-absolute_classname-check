require 'spec_helper'

describe 'relative_classname_inclusion' do
  let(:msg) { 'class included by relative name' }

  context 'with fix disabled' do
    context 'when absolute names are used' do
      let(:code) do
        <<-EOS
        include ::foobar
        include('::foobar')

        class { '::foobar': }
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'when relative names are used' do
      let(:code) do
        <<-EOS
        include foobar
        include(foobar)
        class { 'foobar': }
        EOS
      end

      it 'should detect 3 problems' do
        expect(problems).to have(3).problems
      end

      it 'should create warnings' do
        expect(problems).to contain_warning(msg).on_line(1).in_column(17)
        expect(problems).to contain_warning(msg).on_line(2).in_column(17)
        expect(problems).to contain_warning(msg).on_line(3).in_column(17)
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'when absolute names are used' do
      let(:code) do
        <<-EOS
        include ::foobar
        include('::foobar')

        class { '::foobar': }
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'when relative names are used' do
      let(:code) do
        <<-EOS
        include foobar
        include(foobar)
        class { 'foobar': }
        EOS
      end

      it 'should detect 3 problems' do
        expect(problems).to have(3).problems
      end

      it 'should fix the problems' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(17)
        expect(problems).to contain_fixed(msg).on_line(2).in_column(17)
        expect(problems).to contain_fixed(msg).on_line(3).in_column(17)
      end

      it 'should should add colons' do
        expect(manifest).to eq(
        <<-EOS
        include ::foobar
        include(::foobar)
        class { '::foobar': }
        EOS
        )
      end
    end
  end
end
