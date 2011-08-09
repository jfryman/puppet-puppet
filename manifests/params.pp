class puppet::params {
  $pt_agent_server = 'puppetmaster.us.chstest.net'
  $pt_yumrepo = "http://repo.us.chstest.net/puppet/${::operatingsystem}/${::lsbmajdistrelease}/${::architecture}"
}
