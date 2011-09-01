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

class puppet::repo {
  anchor { 'puppet::repo::begin': }
  anchor { 'puppet::repo::end': }

  Class {
    stage   => 'setup',
    require => Anchor['puppet::repo::begin'],
    before  => Anchor['puppet::repo::end'],
  }

  case $operatingsystem {
    redhat: {
      class { 'puppet::repo::redhat': }
    }
  }
}
