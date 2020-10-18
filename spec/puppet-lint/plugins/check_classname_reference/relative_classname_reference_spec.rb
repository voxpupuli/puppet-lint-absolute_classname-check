require 'spec_helper'

describe 'relative_classname_reference' do
  let(:msg) { 'absolute class name reference' }

  context 'with fix disabled' do
    context 'when absolute names are used' do
      let(:code) do
        <<-EOS
        Class[::foo] -> Class['::bar']

        file { '/path':
          ensure  => present,
          require => Class['::foo', '::bar'],
        }

        file { '/path':
          ensure  => present,
          require => [Class[::foo], Class['::bar']],
        }
        EOS
      end

      it 'should detect 6 problems' do
        expect(problems).to have(6).problems
      end

      it 'should create warnings' do
        expect(problems).to contain_warning(msg).on_line(1).in_column(15)
        expect(problems).to contain_warning(msg).on_line(1).in_column(31)
        expect(problems).to contain_warning(msg).on_line(5).in_column(28)
        expect(problems).to contain_warning(msg).on_line(5).in_column(37)
        expect(problems).to contain_warning(msg).on_line(10).in_column(29)
        expect(problems).to contain_warning(msg).on_line(10).in_column(43)
      end
    end

    context 'when relative names are used' do
      let(:code) do
        <<-EOS
        Class[foo] -> Class['bar']
        file { '/path':
          ensure  => present,
          require => Class['foo', 'bar'],
        }
        file { '/path':
          ensure  => present,
          require => [Class['foo'], Class['bar']],
        }
        EOS
      end

      it 'should not detect a problem' do
        expect(problems).to have(0).problems
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
        Class[::foo] -> Class['::bar']

        file { '/path':
          ensure  => present,
          require => Class['::foo', '::bar'],
        }

        file { '/path':
          ensure  => present,
          require => [Class[::foo], Class['::bar']],
        }
        EOS
      end

      it 'should detect 6 problems' do
        expect(problems).to have(6).problems
      end

      it 'should fix the problems' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(15)
        expect(problems).to contain_fixed(msg).on_line(1).in_column(31)
        expect(problems).to contain_fixed(msg).on_line(5).in_column(28)
        expect(problems).to contain_fixed(msg).on_line(5).in_column(37)
        expect(problems).to contain_fixed(msg).on_line(10).in_column(29)
        expect(problems).to contain_fixed(msg).on_line(10).in_column(43)
      end

      it 'should should remove colons' do
        expect(manifest).to eq(
        <<-EOS
        Class[foo] -> Class['bar']

        file { '/path':
          ensure  => present,
          require => Class['foo', 'bar'],
        }

        file { '/path':
          ensure  => present,
          require => [Class[foo], Class['bar']],
        }
        EOS
        )
      end
    end

    context 'when relative names are used' do
      let(:code) do
        <<-EOS
        Class[foo] -> Class['bar']
        file { '/path':
          ensure  => present,
          require => Class['foo', 'bar'],
        }
        file { '/path':
          ensure  => present,
          require => [Class[foo], Class['bar']],
        }
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end
  end
end
