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

class puppet::client(
  $server
) {
  anchor { 'puppet::client::begin': 
    before => Class['puppet::client::package'],
    notify => Class['puppet::client::service'],
  }

  class { 'puppet::client::package': 
    notify => Class['puppet::client::service'],
  }

  class { 'puppet::client::config': 
    server  => $server,
    require => Class['puppet::client::package'],
    notify  => Class['puppet::client::service'],
  }

  class { 'puppet::client::service': }

  anchor { 'puppet::client::end': 
    require => Class['puppet::client::service'],
  }
}
