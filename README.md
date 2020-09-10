Team and repository tags
========================

[![Team and repository tags](https://governance.openstack.org/tc/badges/puppet-designate.svg)](https://governance.openstack.org/tc/reference/tags/index.html)

<!-- Change things from this point on -->

puppet-designate
================

#### Table of Contents

1. [Overview - What is the designate module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with designate](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - Those with commits](#contributors)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)
9. [Repository - The project source code repository](#repository)

Overview
--------

The designate module is a part of [OpenStack](https://opendev.org/openstack), an effort by the OpenStack infrastructure team to provide continuous integration testing and code review for OpenStack and OpenStack community projects as part of the core software. The module itself is used to flexibly configure and manage the DNS service for OpenStack.

Module Description
------------------

Setup
-----

**What the designate module affects:**

* [Designate](https://docs.openstack.org/designate/latest/), the DNS service for OpenStack.

### Installing designate

    puppet module install openstack/designate

Implementation
--------------

### designate

designate is a combination of Puppet manifest and ruby code to delivery configuration and extra functionality through types and providers.

### Types

#### designate_config

The `designate_config` provider is a children of the ini_setting provider. It allows one to write an entry in the `/etc/designate/designate.conf` file.

```puppet
designate_config { 'DEFAULT/notification_driver' :
  value => messaging,
}
```

This will write `notification_driver=messaging` in the `[DEFAULT]` section.

##### name

Section/setting name to manage from `designate.conf`

##### value

The value of the setting to be defined.

##### secret

Whether to hide the value from Puppet logs. Defaults to `false`.

##### ensure_absent_val

If value is equal to ensure_absent_val then the resource will behave as if `ensure => absent` was specified. Defaults to `<SERVICE DEFAULT>`

Limitations
-----------

None.

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://docs.openstack.org/puppet-openstack-guide/latest/

WORK IN PROGRESS
----------------

✓ Basic structure
✓ DB
✓ Keystone (Users, Services, Endpoints)
✓ Client
✓ designate-api
✓ designate-central
✗ designate-agent (in progress)
✗ designate-sink  (in progress)
✓ An example of site.pp
✓ Write Tests

Setup
-----

### Get Prepared for Deployment

#### Debian/Ubuntu

* Debian testing (jessie) include all designate packages.
* Ubuntu utopic is the minimum requirement for Ubuntu deployment.

#### Red Hat

* Packages are available from RDO: https://www.rdoproject.org/
* See the repo setup instructions for the various RDO deployment methods for
  details on how to use them.

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://docs.openstack.org/puppet-openstack-guide/latest/

Contributors
------------

* https://github.com/openstack/puppet-designate/graphs/contributors

Release Notes
-------------

* https://docs.openstack.org/releasenotes/puppet-designate

Repository
----------

* https://opendev.org/openstack/puppet-designate


