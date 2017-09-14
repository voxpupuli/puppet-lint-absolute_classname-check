puppet-lint-absolute_classname-check
====================================

[![Build Status](https://img.shields.io/travis/puppet-community/puppet-lint-absolute_classname-check.svg)](https://travis-ci.org/puppet-community/puppet-lint-absolute_classname-check)
[![Gem Version](https://img.shields.io/gem/v/puppet-lint-absolute_classname-check.svg)](https://rubygems.org/gems/puppet-lint-absolute_classname-check)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-lint-absolute_classname-check.svg)](https://rubygems.org/gems/puppet-lint-absolute_classname-check)
[![Coverage Status](https://img.shields.io/coveralls/puppet-community/puppet-lint-absolute_classname-check.svg)](https://coveralls.io/r/puppet-community/puppet-lint-absolute_classname-check?branch=master)
[![Gemnasium](https://img.shields.io/gemnasium/puppet-community/puppet-lint-absolute_classname-check.svg)](https://gemnasium.com/puppet-community/puppet-lint-absolute_classname-check)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)

A puppet-lint plugin to check that classes are included by their absolute name **in Puppet 3 only**.

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

Including a class by a relative name might lead to unexpected results **in Puppet 3 only**. This plugin is **not** recommended for use with Puppet 4+.

#### What you have done

```puppet
include foobar
```

#### What you should have done

```puppet
include ::foobar
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

## Transfer Notice

This plugin was originally authored by [Camptocamp](http://www.camptocamp.com).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Camptocamp.

Previously: https://github.com/camptocamp/puppet-lint-absolute_classname-check
