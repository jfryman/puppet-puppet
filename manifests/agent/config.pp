class puppet::agent::config(
  $environment,
  $puppetmaster
) {
  File {
    owner => $puppet::params::pt_puppet_user,
    group => $puppet::params::pt_puppet_group,
    mode  => '0644',
  }
  Exec {
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  #exec{'clean_ssl':
  #  command => "rm -rf ssl/",
  #  cwd     => "${puppet::params::pt_puppet_confdir}",
  #  unless  => "test -f ${puppet:params::pt_puppet_confidr}/ssl/certs/${fqdn}.pem",
  #  refreshonly => true,
  #  notify      => Service['pe-puppet'],
  #}
  file { "${puppet::params::pt_puppet_confdir}/puppet.conf":
    ensure  => file,
    content => template('puppet/puppet/puppet_agent.conf.erb'),
    notify      => Service['pe-puppet'],
    #  notify  => Exec['clean_ssl'],
  }
  user { $puppet::params::pt_puppet_user:
    ensure  => present,
    uid     => $puppet::params::pt_puppet_uid,
    gid     => $puppet::params::pt_puppet_group,
    comment => 'Enterprise Distribution Puppet',
    home    => $puppet::params::pt_puppet_home,
    shell   => $pt_puppet_shell,
  }
  group { $puppet::params::pt_puppet_group:
    ensure => present,
    gid    => $puppet::params::pt_puppet_gid,
  }

  file { $puppet::params::pt_puppet_vardir:
    ensure => directory,
  }
  file { $puppet::params::pt_puppet_home:
    ensure => directory,
  }
  file { $puppet::params::pt_puppet_rundir:
    ensure => directory,
  }
}
