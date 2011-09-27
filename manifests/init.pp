# Class: puppet
#
# Description
#   This module is designed to install and manage a Puppet Master
#   and Puppet Agents. 
#
#   This module has been built and tested on RHEL systems.
#
# Parameters:
#  $agent: Flag to install an agent on a node (true|false)
#  $master: Flag to install a Puppet Master on a node (true|false)
#  $dashboard: Flag to install Puppet Dashboard on a node (true|false)
#  $server: [Puppet Master] Name of Puppet Master
#  $autosign: [Puppet Master] Flag to control autosigning of certificates (true|false)
#  $autosign_acl: [Puppet Master] Array of values to automatically sign certificates. 
#  $certdnsnames: [Puppet Master] Array of values as subjectAlternateNames for the Puppet Master CA
#  $reports: [Puppet Master] What report types are configured to be used
#  $reporturl: [Puppet Master] Location of HTTP Report Type
#  $enc: [Puppet Master] Type of External Node Terminus 
#  $enc_binary: [Puppet Master] Path to the ENC binary
#
# Actions:
#   This module will install Puppet and configure it to build 
#
# Requires:
#  - Class[ruby]. Class to install Ruby on a system
#  - Class[apache]. Puppet Labs class to install Apache. [https://github.com/puppetlabs/puppetlabs-apache]
#  - Class[stdlib]. This is Puppet Labs standard library to include additional methods for use within Puppet. [https://github.com/puppetlabs/puppetlabs-stdlib]
#
# Sample Usage:
#  class { 'puppet': 
#    master => 'true',
#    server => 'puppetmaster.us.chs.net',
#    autosign => 'true',
#  }
class puppet(
  $agent        = 'true',
  $master       = 'false',
  $dashboard    = 'false',
  $server       = '',
  $autosign     = '',
  $autosign_acl = '',
  $certdnsnames = '',
  $reports      = '',
  $reporturl    = '',
  $enc          = '',
  $enc_binary   = ''
) {
  include stdlib
  include ruby
  include puppet::params

  if $server == '' { $REAL_server = $::fqdn }
  else { $REAL_server = $server}

  if $autosign == '' { $REAL_autosign = $puppet::params::pt_puppet_autosign }
  else { $REAL_autosign = $autosign }

  if $autosign_acl == '' { $REAL_autosign_acl = $puppet::params::pt_puppet_autosign_acl }
  else { $REAL_autosign_acl = $autosign_acl }

  if $certdnsnames == '' { $REAL_certdnsnames = $puppet::params::pt_puppet_certdnsnames }
  else { $REAL_certdnsnames = $certdnsnames }

  if $reports == '' { $REAL_reports = $puppet::params::pt_puppet_reports }
  else { $REAL_reports = $reports }

  if $reporturl == '' { $REAL_reporturl = $puppet::params::pt_puppet_reporturl }
  else { $REAL_reporturl = $reporturl }

  if $enc == '' { $REAL_enc = $puppet::params::pt_puppet_enc }
  else { $REAL_enc = $enc }

  if $enc_binary == '' { $REAL_enc_binary = $puppet::params::pt_puppet_enc_binary }
  else { $REAL_enc_binary = $enc_binary }
 
  anchor { 'puppet::begin': }
  -> class { 'puppet::common': }
  -> anchor { 'puppet::end': }

  if $master == 'true' { 
    class { 'puppet::master':
      server       => $REAL_server,
      autosign     => $REAL_autosign,
      autosign_acl => $REAL_autosign_acl,
      certdnsnames => $REAL_certdnsnames,
      reports      => $REAL_reports,
      reporturl    => $REAL_reporturl,
      enc          => $REAL_enc,
      enc_binary   => $REAL_enc_binary,
      require      => Class['puppet::common'],
      before       => Anchor['puppet::end'],
    }
  }
 
  if $dashboard == 'true' {
    class { 'puppet::dashboard':
      require => Class['puppet::common'],
      before  => Anchor['puppet::end'],
    } 
  }

  if $agent == 'true' { 
    class { 'puppet::agent': 
      require => Class['puppet::common'],
      before  => Anchor['puppet::end'],
    } 
  }
}
