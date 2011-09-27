# Class: puppet::master::package
#
# Description
#   This class is designed to install Puppet
#
# Parameters:
#   This class takes no  parameters
#
# Actions:
#   This class installs Gems systems.
#
# Requires:
#   This module has no requirements.   
#
# Sample Usage:
#   This method should not be called directly.
class puppet::master::package {
  @package { 'puppet': 
    ensure   => $puppet::params::pt_puppet_version, 
    provider => 'gem',
    tag      => 'puppet-server-package',
  }
  @package { 'facter': 
    ensure   => $puppet::params::pt_facter_version, 
    provider => 'gem',
    tag      => 'puppet-server-package',
  }
  Package<| tag == 'puppet-server-package' |>
}
