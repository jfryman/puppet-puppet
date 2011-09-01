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

class puppet::client::package {
  anchor { 'puppet::client::package::begin': }
  anchor { 'puppet::client::package::end': }

  Class {
    require => Anchor['puppet::client::package::begin'],
    before  => Anchor['puppet::client::package::end'],    
  }

  case $operatingsystem {
    redhat: {
      class { 'puppet::client::package::redhat': }
    }
  }
}
