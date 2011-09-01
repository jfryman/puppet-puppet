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

class puppet::client::package::redhat {
  $packages = [
    'pe-ruby-libs',
    'pe-ruby',
    'pe-ruby-shadow',
    'pe-augeas-libs',
    'pe-facter',
    'pe-ruby-irb',
    'pe-augeas',
    'pe-ruby-rdoc',
    'pe-rubygems',
    'pe-puppet',
    'pe-ruby-augeas',
    'pe-rubygem-puppet-module',
    'pe-ruby-ldap',
    'pe-ruby-ri',
  ]
  
  package { $packages:
    ensure => present,
  }
}
