# Class: tftp
#
# This module manages tftp
#
# Requires: class xinetd
#
# Sample Usage: include tftp
#
class tftp ($base = "/usr/local/tftpboot",
            $base_alias = "",
            $refuse = []) {

    include xinetd

    package { "tftp-server":
        require => Class["xinetd"],
    } # package

    file { "$base":
        ensure => directory;
    } # file

    if $base_alias {
      file { "$base_alias":
          ensure => link,
          target => "$base",
          force  => true;
      }
    }

    if $refuse {
      $refuse_args = inline_template("<%= refuse.map{ |ref| '-r ' + ref + ' ' } %>")
    }

    $server_args = "$refuse_args-s $base"

    xinetd::service {"tftp":
        port        => "69",
        server      => "/usr/sbin/in.tftpd",
        server_args => $server_args,
        socket_type => "dgram",
        protocol    => "udp",
        cps         => "100 2",
        flags       => "IPv4",
        per_source  => "11",
    } # xinetd::service

    service { "tftp":
        enable    => true,
        require   => [ Package["tftp-server"], Xinetd::Service["tftp"] ],
    } # service
} # class tftp
