# Class: puppet::params
#
# Description
#   This class is designed to carry default parameters for 
#   Class: puppet.  
#
# Parameters:
#  $pt_facter_version: Version of Facter to install.
#  $pt_puppet_version: Version of Puppet to install
#  $pt_puppet_confdir: Base configuration directory to install puppet
#  $pt_puppet_vardir: Var directory for puppet to operate
#  $pt_puppet_rundir: Directory where puppet will execute out of.
#  $pt_puppet_logdir: Directory where puppet will log.
#  $pt_puppet_user: Puppet user name
#  $pt_puppet_uid: Puppet UID 
#  $pt_puppet_group: Puppet Group Name
#  $pt_puppet_gid: Puppet GID
#  $pt_puppet_autosign: Enable Autosign (true|false)
#  $pt_puppet_autosign_acl: Array of values - default autosign acls.
#  $pt_puppet_certdnsnames: Array of values - default alternateSubjectName for Puppet CA
#  $pt_puppet_reports: Array of values - default report types for Puppet
#  $pt_puppet_reporturl: Location of URL for http report type.
#  $pt_puppet_enc: Puppet ENC type
#  $pt_puppet_enc_binary: Location of ENC binary
#  $pt_puppet_rackdir: Directory to stage the Puppet Master rack application.
#  $pt_puppet_rackdir_directories: Directories that need to exist in order to bootstrap a rack application.
#  $pt_puppet_base_directories: Directories that need to exist in order to bootstrap puppet manfifests/modules.
#
# Actions:
#   This module does not perform any actions.
#
# Requires:
#   This module has no requirements.   
#
# Sample Usage:
#   This method should not be called directly.
class puppet::params {
  $pt_puppetmaster = 'puppetmaster.us.chs.net'

  # Versions of Puppet to Install
  $pt_facter_version = '1.6.0'
  $pt_puppet_version = '2.6.9'

  # Base configuration for Puppet Users
  $pt_var_base       = '/var/opt/'
  $pt_puppet_confdir = '/etc/puppetlabs/puppet'
  $pt_puppet_vardir  = "${pt_var_base}/pe-puppet"
  $pt_puppet_rundir  = "/var/run/pe-puppet"
  $pt_puppet_logdir  = "/var/log/pe-puppet"
  $pt_puppet_user    = 'pe-puppet'
  $pt_puppet_uid     = '401'
  $pt_puppet_group   = 'pe-puppet'
  $pt_puppet_gid     = '401'
  $pt_puppet_home    = '/var/opt/lib/pe-puppet'
  $pt_puppet_shell   = '/sbin/nologin'

  # Default PuppetMaster Options
  $pt_puppet_autosign     = 'false'
  $pt_puppet_autosign_acl = [ "*.${::domain}" ]
  $pt_puppet_certdnsnames = [ "${::fqdn}" ]
  $pt_puppet_reports      = ['http', 'store']
  $pt_puppet_reporturl    = 'http://localhost:3000/reports'
  $pt_puppet_enc          = 'exec'
  $pt_puppet_enc_binary   = '/etc/puppet/puppet-dashboard/external_node'

  $pt_puppet_rackdir = "${pt_puppet_confdir}/puppetmaster"
  $pt_puppet_rackdir_directories = [ "${pt_puppet_rackdir}", 
                                     "${pt_puppet_rackdir}/tmp", 
                                     "${pt_puppet_rackdir}/public",
                                   ]

  $pt_puppet_base_directories = [ "${pt_var_base}",
                                  "${pt_var_base}/lib",
                                  "${pt_puppet_confdir}",
                                  "${pt_puppet_confdir}/environments",
                                  "${pt_puppet_confdir}/modules",
                                  "${pt_puppet_confdir}/modules/site",
                                  "${pt_puppet_confdir}/modules/dist",
                                  "${pt_puppet_confdir}/manifests",
                                  $pt_puppet_rundir,
                                ]

  case $::operatingsystem {
    redhat,centos,fedora: {
      $pt_puppet_agent_packages = [ 'pe-augeas', 'pe-augeas-libs', 'pe-facter', 
                                    'pe-puppet', 'pe-puppet-enterprise-release',
                                    'pe-ruby', 'pe-ruby-augeas', 'pe-rubygem-puppet-module',
                                    'pe-rubygems', 'pe-ruby-irb', 'pe-ruby-ldap', 
                                    'pe-ruby-libs', 'pe-ruby-rdoc', 'pe-ruby-ri',
                                    'pe-ruby-shadow',
                                  ]
    }
  }
}
