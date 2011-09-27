class puppet(
  $agent        = 'true',
  $master       = 'false',
  $dashboard    = 'false',
  $server       = '',
  $autosign     = '',
  $autosign_acl = '',
  $certdnsnames = '',
  $reports      = '',
  $reporturl    = '',
  $enc          = '',
  $enc_binary   = ''
) {
  include stdlib
  include ruby
  include puppet::params

  if $server == '' { $REAL_server = $::fqdn }
  else { $REAL_server = $server}

  if $autosign == '' { $REAL_autosign = $puppet::params::pt_puppet_autosign }
  else { $REAL_autosign = $autosign }

  if $autosign_acl == '' { $REAL_autosign_acl = $puppet::params::pt_puppet_autosign_acl }
  else { $REAL_autosign_acl = $autosign_acl }

  if $certdnsnames == '' { $REAL_certdnsnames = $puppet::params::pt_puppet_certdnsnames }
  else { $REAL_certdnsnames = $certdnsnames }

  if $reports == '' { $REAL_reports = $puppet::params::pt_puppet_reports }
  else { $REAL_reports = $reports }

  if $reporturl == '' { $REAL_reporturl = $puppet::params::pt_puppet_reporturl }
  else { $REAL_reporturl = $reporturl }

  if $enc == '' { $REAL_enc = $puppet::params::pt_puppet_enc }
  else { $REAL_enc = $enc }

  if $enc_binary == '' { $REAL_enc_binary = $puppet::params::pt_puppet_enc_binary }
  else { $REAL_enc_binary = $enc_binary }
 
  anchor { 'puppet::begin': }
  -> class { 'puppet::common': }
  -> anchor { 'puppet::end': }

  if $master == 'true' { 
    class { 'puppet::master':
      server       => $REAL_server,
      autosign     => $REAL_autosign,
      autosign_acl => $REAL_autosign_acl,
      certdnsnames => $REAL_certdnsnames,
      reports      => $REAL_reports,
      reporturl    => $REAL_reporturl,
      enc          => $REAL_enc,
      enc_binary   => $REAL_enc_binary,
      require      => Class['puppet::common'],
      before       => Anchor['puppet::end'],
    }
  }
 
  if $dashboard == 'true' {
    class { 'puppet::dashboard':
      require => Class['puppet::common'],
      before  => Anchor['puppet::end'],
    } 
  }

  if $agent == 'true' { 
    class { 'puppet::agent': 
      require => Class['puppet::common'],
      before  => Anchor['puppet::end'],
    } 
  }
}
