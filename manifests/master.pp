class puppet::master(
 $server,
 $autosign,
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
       certdnsnames => $certdnsnames,
       reports      => $reports,
       reporturl    => $reporturl,
       enc          => $enc,
       enc_binary   => $enc_binary,
     }
  ~> class { 'puppet::master::service': }
  -> anchor { 'puppet::master::end': }
}
