class puppet::agent(
  $environment,
  $puppetmaster
) {
  include puppet::params

  anchor { 'puppet::agent::begin': }
  -> class { 'puppet::agent::package': }
  -> class { 'puppet::agent::config': 
    environment  => $environment,
    puppetmaster => $puppetmaster,
  }
  ~> class { 'puppet::agent::service': }
  -> anchor { 'puppet::agent::end': }
}
