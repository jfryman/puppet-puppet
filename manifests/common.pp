# Class: puppet::common
#
# Description
#   This class is designed to configure any common elements of the Puppet Install
#
# Parameters:
#  This module takes no parameters
# 
# Actions:
#   Install Users and Bootstrap working directories.
#
# Requires:
#   This module has no requirements.   
#
# Sample Usage:
#   This method should not be called directly.
class puppet::common {
  File {
    owner => 'root',
    group => $puppet::params::pt_puppet_group,
    mode  => '0664',
  }
  
  user { $puppet::params::pt_puppet_user:
    ensure => 'present',
    uid    => $puppet::params::pt_puppet_uid,
    gid    => $puppet::params::pt_puppet_gid,
    home   => '/var/lib/puppet',
    shell  => '/sbin/nologin',
  }
  group { $puppet::params::pt_puppet_group:
    ensure => 'present',
    gid    => $puppet::params::pt_puppet_gid,
  }

  file { $puppet::params::pt_puppet_base_directories:
    ensure => directory,
  }
}
