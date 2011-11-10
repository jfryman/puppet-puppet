class puppet::agent::package {
  package { $puppet::params::pt_puppet_agent_packages:
    ensure => 'present',
  }
}