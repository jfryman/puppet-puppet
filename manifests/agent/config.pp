class puppet::agent::config(
  $environment,
  $puppetmaster
) {
  File {
    owner => $puppet::params::pt_puppet_user,
    group => $puppet::params::pt_puppet_group,
    mode  => '0644',
  }

  file { "${puppet::params::pt_puppet_confdir}/puppet.conf":
    ensure  => file,
    content => template('puppet/puppet/puppet_agent.conf.erb'),
  }
}
