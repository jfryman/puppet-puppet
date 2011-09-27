class puppet::master::config(
  $server,
  $autosign,
  $certdnsnames,
  $reports,
  $reporturl,
  $enc,
  $enc_binary
) {
  File {
    owner => 'root',
    group => $puppet::params::pt_puppet_gid,
    mode  => '0644',
  }

  file { $puppet::params::pt_puppet_rackdir_directories:
    ensure => directory,
  }
  file { "${puppet::params::pt_puppet_rackdir}/config.ru":
    ensure => file,
    source => 'puppet:///modules/puppet/rack/config.ru',
  }
  file { "${puppet::params::pt_puppet_confdir}/puppet.conf":
    ensure  => file,
    content => template('puppet/puppet/puppet.conf.erb')
  }
  apache::vhost { $server:
    port      => '8140',
    priority  => '10',
    template  => 'puppet/rack/vhost-puppetmaster.conf.erb',
    docroot   => $puppet::params::pt_puppet_rackdir,
    passenger => 'true',
  }
}
