class puppet(
  $client = 'true',
  $server = 'false'
) {
  include stdlib
  include ruby
  include puppet::params

  anchor { 'puppet::begin': }
  anchor { 'puppet::end': }

  if $server == 'true' { 
    class { 'puppet::server':
      require => Anchor['puppet::begin'],
      before  => Anchor['puppet::end'],
    }
  }
  
  if $client == 'true' { 
    class { 'puppet::client': 
      require => [ Anchor['puppet::begin'], Class['puppet::server'] ],
      before  => Anchor['puppet::end'],
    } 
  }
}
