# Class: puppet
#
# Description
#   NOTE: UNDER DEVELOPMENT
# Parameters:
#   
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet(
  $type   = 'client',
  $server = ''
) {
  include stdlib
  include puppet::params

  if $server == '' {
    $REAL_server = $puppet::params::pt_agent_server
  } else {
    $REAL_server = $server
  }

  anchor { 'puppet::begin': }
  anchor { 'puppet::end': }
  
  class { 'puppet::repo': 
    stage   => 'setup',
    require => Anchor['puppet::begin'],
    before  => Anchor['puppet::end'],
  }
  
  if $type == 'client' {
    class { 'puppet::client': 
      server  => $REAL_server,
      require => [Anchor['puppet::begin'], Class['puppet::repo']],
      before  => Anchor['puppet::end'],
    }
  }
  elsif $type == 'puppetmaster' {
    class { 'puppet::server': 
      require => [Anchor['puppet::begin'], Class['puppet::repo']],
      before  => Anchor['puppet::end'],
    }
  }
  else {
    fail('Invalid Type Defined: ${type}')
  }
}
