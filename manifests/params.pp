class puppet::params {

  # Versions of Puppet to Install
  $pt_facter_version = '1.6.0'
  $pt_puppet_version = '2.6.9'

  # Base configuration for Puppet Users
  $pt_puppet_confdir = '/etc/puppet'
  $pt_puppet_vardir  = '/var/lib/puppet'
  $pt_puppet_rundir  = "${pt_puppet_vardir}/run"
  $pt_puppet_logdir  = "${pt_puppet_vardir}/log"
  $pt_puppet_user    = 'puppet'
  $pt_puppet_uid     = '401'
  $pt_puppet_group   = 'puppet'
  $pt_puppet_gid     = '401'

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

  $pt_puppet_base_directories = [ "${pt_puppet_confdir}", 
                                  "${pt_puppet_confdir}/modules",
                                  "${pt_puppet_confdir}/modules/site",
                                  "${pt_puppet_confdir}/modules/dist",
                                  "${pt_puppet_confdir}/manifests",
                                ]
}
