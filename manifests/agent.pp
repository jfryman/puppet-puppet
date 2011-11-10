class puppet::agent(
  $environment = 'production'
) {
  include puppet::params

  anchor { 'puppet::agent::begin': }
  -> class { 'puppet::agent::package': }
  -> class { 'puppet::agent::config': }
  ~> class { 'puppet::agent::service': }
  -> anchor { 'puppet::agent::end': }
}
