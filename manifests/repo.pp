class puppet::repo {
  anchor { 'puppet::repo::begin': }
  anchor { 'puppet::repo::end': }

  Class {
    stage   => 'setup',
    require => Anchor['puppet::repo::begin'],
    before  => Anchor['puppet::repo::end'],
  }

  case $operatingsystem {
    rhel: {
      class { 'puppet::repo::redhat': }
    }
  }
}
