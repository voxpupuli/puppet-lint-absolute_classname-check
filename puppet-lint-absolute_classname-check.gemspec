Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-absolute_classname-check'
  spec.version     = '5.0.0'
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
  spec.summary     = 'A puppet-lint plugin to check that classes are not included or referenced by their absolute name.'
  spec.description = <<-EOF
    A puppet-lint plugin to check that classes are not included or referenced by their absolute name.
  EOF

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'puppet-lint', '~> 5.1'
end
