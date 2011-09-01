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

class puppet::client::service {
  service { 'pe-puppet':
    ensure     => 'running',
    enable     => 'true',
    hasstatus  => 'true',
    hasrestart => 'true',
  }
}
