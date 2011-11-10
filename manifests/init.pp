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
  $environment  = 'production'
) {
  include stdlib
  include puppet::params
  
  if $agent == 'true' { 
    class { 'puppet::agent': 
      environment => $environment,
      require     => Anchor['puppet::begin::agent'],
      before      => Anchor['puppet::end::agent'],
    } 
  }
  
  # Anchors
  anchor { 'puppet::begin': }
  -> anchor { 'puppet::begin::master': }
  -> anchor { 'puppet::end::master': }
  -> anchor { 'puppet::begin::agent': }
  -> anchor { 'puppet::end::agent': }
  -> anchor { 'puppet::end': }
}
