puppet-lint-absolute_classname-check
====================================

[![Build Status](https://img.shields.io/travis/voxpupuli/puppet-lint-absolute_classname-check.svg)](https://travis-ci.org/voxpupuli/puppet-lint-absolute_classname-check)
[![Gem Version](https://img.shields.io/gem/v/puppet-lint-absolute_classname-check.svg)](https://rubygems.org/gems/puppet-lint-absolute_classname-check)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-lint-absolute_classname-check.svg)](https://rubygems.org/gems/puppet-lint-absolute_classname-check)
[![Coverage Status](https://img.shields.io/coveralls/voxpupuli/puppet-lint-absolute_classname-check.svg)](https://coveralls.io/r/voxpupuli/puppet-lint-absolute_classname-check?branch=master)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)

A puppet-lint plugin to check that classes are included by their absolute name.


## Table of contents

* [Installing](#installing)
  * [From the command line](#from-the-command-line)
  * [In a Gemfile](#in-a-gemfile)
* [Checks](#checks)
  * [Relative class name inclusion](#relative-class-name-inclusion)
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

## Transfer Notice

This plugin was originally authored by [Camptocamp](http://www.camptocamp.com).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Camptocamp.

Previously: https://github.com/camptocamp/puppet-lint-absolute_classname-check

## Release information

To make a new release, please do:
* Update the version in the `puppet-lint-absolute_classname-check.gemspec` file
* Update the version in the Rakefile
* Install gems with `bundle install --with release --path .vendor`
* generate the changelog with `bundle exec rake changelog`
* Create a PR with it
* After it got merged, push a tag. Travis will do the actual release
