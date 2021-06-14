puppet-lint-absolute_classname-check
====================================

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-absolute_classname-check.svg)](https://github.com/voxpupuli/puppet-lint-absolute_classname-check/blob/master/LICENSE)
[![Test](https://github.com/voxpupuli/puppet-lint-absolute_classname-check/actions/workflows/test.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-absolute_classname-check/actions/workflows/test.yml)
[![Release](https://github.com/voxpupuli/puppet-lint-absolute_classname-check/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-absolute_classname-check/actions/workflows/release.yml)
[![RubyGem Version](https://img.shields.io/gem/v/puppet-lint-absolute_classname-check.svg)](https://rubygems.org/gems/puppet-lint-absolute_classname-check)
[![RubyGem Downloads](https://img.shields.io/gem/dt/puppet-lint-absolute_classname-check.svg)](https://rubygems.org/gems/puppet-lint-absolute_classname-check)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)

A puppet-lint plugin to check that classes are included by their absolute name.


## Table of contents

* [Installing](#installing)
  * [From the command line](#from-the-command-line)
  * [In a Gemfile](#in-a-gemfile)
* [Checks](#checks)
  * [Relative class name inclusion](#relative-class-name-inclusion)
  * [Relative class reference](#relative-classname-reference)
* [Transfer notice](#transfer-notice)
* [Release Informaion](#release-information)

## Installing

### From the command line

```shell
$ gem install puppet-lint-absolute_classname-check
```

### In a Gemfile

```ruby
gem 'puppet-lint-absolute_classname-check', :require => false
```

## Checks

### Relative class name inclusion

Including a class by a relative name might lead to unexpected results [in Puppet 3](https://docs.puppet.com/puppet/3/lang_namespaces.html#relative-name-lookup-and-incorrect-name-resolution). That's why a lot of manifests explicitly include by the absolute name. Since Puppet 4 names are always absolute and this is no longer needed. This lint check helps to clean up your manifests.

#### What you have done

```puppet
include ::foobar
```

#### What you should have done

```puppet
include foobar
```

#### Disabling the check

To disable this check, you can add `--no-relative_classname_inclusion-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-relative_classname_inclusion-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_relative_classname_inclusion')
```

### Relative class reference

#### What you have done

```puppet
Class['::foo'] -> Class['::bar']
```

#### What you should have done

```puppet
Class['foo'] -> Class['bar']
```

#### Disabling the check

To disable this check, you can add `--no-relative_classname_reference-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-relative_classname_reference-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_relative_classname_reference')
```

## Transfer Notice

This plugin was originally authored by [Camptocamp](http://www.camptocamp.com).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Camptocamp.

Previously: https://github.com/camptocamp/puppet-lint-absolute_classname-check

## License

This gem is licensed under the Apache-2 license.

## Release information

To make a new release, please do:
* Update the version in the `puppet-lint-absolute_classname-check.gemspec` file
* Install gems with `bundle install --with release --path .vendor`
* generate the changelog with `bundle exec rake changelog`
* Create a PR with it
* After it got merged, push a tag. Travis will do the actual release
