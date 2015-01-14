puppet-lint-absolute_classname-check
=================================

[![Build Status](https://travis-ci.org/camptocamp/puppet-lint-absolute_classname-check.svg)](https://travis-ci.org/camptocamp/puppet-lint-absolute_classname-check)
[![Code Climate](https://codeclimate.com/github/camptocamp/puppet-lint-absolute_classname-check/badges/gpa.svg)](https://codeclimate.com/github/camptocamp/puppet-lint-absolute_classname-check)
[![Gem Version](https://badge.fury.io/rb/puppet-lint-absolute_classname-check.svg)](http://badge.fury.io/rb/puppet-lint-absolute_classname-check)
[![Coverage Status](https://img.shields.io/coveralls/camptocamp/puppet-lint-absolute_classname-check.svg)](https://coveralls.io/r/camptocamp/puppet-lint-absolute_classname-check?branch=master)

A puppet-lint plugin to check that classes are included by their absolute name.


## Checks

### Relative class name inclusion

Including a class by a relative name might lead to unexpected results.

#### What you have done

```puppet
include foobar
```

#### What you should have done

```puppet
include ::foobar
```

#### Disabling the check

To disable this check, you can add `--no-absolute_classname-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-absolute_classname-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_absolute_classname')
```
