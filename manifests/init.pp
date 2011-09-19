# Class: tftp
#
# This module manages a tftp server
#
# see http://www.puppetlabs.com/blog/design-pattern-for-dealing-with-data/
#
# Author: Garrett Honeycutt <code@garretthoneycutt.com>
#
# Requires:
#   class xinetd
#
# Sample Usage: include tftp
#
class tftp {

  include tftp::data
  include xinetd

  package { $tftp::data::tftp_server_package_name:
    require => Class['xinetd'],
  } # package

  file { $tftp::data::tftp_server_base_dir:
    ensure  => directory,
    require => Package[$tftp::data::tftp_server_package_name];
  } # file

  xinetd::service { 'tftp':
    port        => $tftp::data::tftp_server_port,
    server      => $tftp::data::tftp_server_binary,
    server_args => $tftp::data::tftp_server_args,
    socket_type => $tftp::data::tftp_server_socket_type,
    protocol    => $tftp::data::tftp_server_protocol,
    cps         => $tftp::data::tftp_server_cps,
    flags       => $tftp::data::tftp_server_flags,
    per_source  => $tftp::data::tftp_server_per_source,
  } # xinetd::service

  service { $tftp::data::tftp_server_service_name:
    enable    => true,
    require   => [ File[$tftp::data::tftp_server_base_dir], Xinetd::Service['tftp'] ],
  } # service
} # class tftp
