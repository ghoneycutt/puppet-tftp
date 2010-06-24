# Class: tftp
#
# This module manages tftp
#
# Requires: class xinetd
#
# Sample Usage: include tftp
#
class tftp {

    include xinetd

    $base = "/data/tftpboot"

    package { "tftp-server":
        require => Class["xinetd"],
    } # package

    file { "$base":
        ensure => directory;
    } # file

    xinetd::service {"tftp":
        port        => "69",
        server      => "/usr/sbin/in.tftpd",
        server_args => "-s $base",
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
