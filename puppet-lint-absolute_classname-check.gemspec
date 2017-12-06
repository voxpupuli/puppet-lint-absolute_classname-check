Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-absolute_classname-check'
  spec.version     = '0.2.5'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-absolute_classname-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'A puppet-lint plugin to check that classes are included by their absolute name.'
  spec.description = <<-EOF
    A puppet-lint plugin to check that classes are included by their absolute name.
  EOF

  spec.add_dependency             'puppet-lint', '>= 1.0', '< 3.0'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'mime-types'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'rspec-its'
end
