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
