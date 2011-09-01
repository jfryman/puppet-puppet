# Class: 
#
# Description
#
# Parameters:
#   
# Actions:
#
# Requires:
#
# Sample Usage:
#

class puppet::client::config(
  $server
) {
  file { '/usr/local/bin/facter':
    ensure => symlink,
    target => '/opt/puppet/bin/facter',
  }
  file { '/usr/local/bin/puppet':
    ensure => symlink,
    target => '/opt/puppet/bin/puppet',
  }
  file { '/usr/local/bin/puppet-module':
    ensure => symlink,
    target => '/opt/puppet/bin/puppet-module',
  }
  file { '/usr/local/bin/pe-man':
    ensure => symlink,
    target => '/opt/puppet/bin/pe-man',
  }
  file { '/opt/puppetlabs/puppet/puppet.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/client_puppet.conf.erb'),
  }
}
