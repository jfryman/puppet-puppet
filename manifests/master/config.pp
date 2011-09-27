class puppet::master::config(
  $server,
  $autosign,
  $autosign_acl,
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
  Exec {
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin'
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
  # How do I get puppet to autogen me an SSL chain?

  if $autosign == 'true' {
    file { "${puppet::params::pt_puppet_confdir}/autosign.conf":
      ensure  => file,
      content => template('puppet/puppet/autosign.conf.erb'),
    }
  }

  # Multiple templates concated here? 
  file { "${puppet::params::pt_puppet_confdir}/auth.conf":
    ensure  => file,
    content => template('puppet/puppet/auth.base.conf.erb')
  }
  file { "${puppet::params::pt_puppet_confdir}/fileserver.conf":
    ensure  => file,
    content => template('puppet/puppet/fileserver.base.conf.erb')
  }
  # End hypotehtical question re: templates

  exec { 'generate-puppetmaster-ssl':
    command => inline_template("puppet cert --generate <%= server %> --certdnsnames '<%= certdnsnames.join(':') %>:puppet' --verbose --color=false || true"),
    creates => "${puppet::params::pt_puppet_confdir}/ssl/certs/${server}.pem",
    before  => Apache::Vhost[$server],
  } 

  apache::vhost { $server:
    port      => '8140',
    priority  => '10',
    template  => 'puppet/rack/vhost-puppetmaster.conf.erb',
    docroot   => $puppet::params::pt_puppet_rackdir,
    passenger => 'true',
  }
}
