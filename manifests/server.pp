class puppet::server {
  anchor { 'puppet::server::begin': }
  -> class { 'puppet::server::package': }
  -> class { 'puppet::server::config': }
  ~> class { 'puppet::server::service': }
  -> anchor { 'puppet::server::end': }
}