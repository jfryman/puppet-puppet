class puppet::agent::service {
  service { 'pe-puppet': 
    ensure     => 'running',
    enable     => 'true',
    hasstatus  => 'true',
    hasrestart => 'true',
  }
}