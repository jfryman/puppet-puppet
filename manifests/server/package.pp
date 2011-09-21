class puppet::server::package {
  @package { 'puppet': 
    ensure   => $puppet::params::pt_puppet_version, 
    provider => 'gem',
    tag      => 'puppet-server-package',
  }
  @package { 'facter': 
    ensure   => $puppet::params::pt_facter_version, 
    provider => 'gem',
    tag      => 'puppet-server-package',
  }
  Package<| tag == 'puppet-server-package' |>
}
