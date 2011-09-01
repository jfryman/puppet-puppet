# Class: 
#
# Description
#
# Parameters:
#   
# Actions:
#
# Requires:
#
# Sample Usage:
#

class puppet::repo::package::redhat {
  yumrepo { 'puppet-enterprise':
    baseurl => $puppet::params::pt_yumrepo,
    descr   => 'Puppet Enterprise Repository',
    enabled => '1',
  }
}