# Class: puppet::master
#
# Description
#   This class is designed to manage the configuration/installation 
#   of a Puppet Master on a system. 
#
# Parameters:
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
#   This class ensures the proper version of Puppet is installed, configured, and running. 
#
# Requires:
#   This module has no requirements.   
#
# Sample Usage:
#   This method should not be called directly.
class puppet::master(
 $server,
 $autosign,
 $autosign_acl,
 $certdnsnames,
 $reports,
 $reporturl,
 $enc,
 $enc_binary
) {
  anchor { 'puppet::master::begin': }
  -> class { 'puppet::master::package': }
  -> class { 'puppet::master::config': 
       server       => $server,
       autosign     => $autosign,
       autosign_acl => $autosign_acl,
       certdnsnames => $certdnsnames,
       reports      => $reports,
       reporturl    => $reporturl,
       enc          => $enc,
       enc_binary   => $enc_binary,
     }
  ~> class { 'puppet::master::service': }
  -> anchor { 'puppet::master::end': }
}
