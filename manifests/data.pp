class tftp::data {

  include common::data

  if $common::data::tftp_server_base_dir {
    $tftp_server_base_dir = $common::data::tftp_server_base_dir
  } else {
    $tftp_server_base_dir = '/tftpboot'
  } # fi

  if $common::data::tftp_server_package_name {
    $tftp_server_package_name = $common::data::tftp_server_package_name
  } else {
    $tftp_server_package_name = 'tftp-server'
  } # fi

  if $common::data::tftp_server_service_name {
    $tftp_server_service_name = $common::data::tftp_server_service_name
  } else {
    $tftp_server_service_name = 'tftp'
  } # fi

  if $common::data::tftp_server_port {
    $tftp_server_port = $common::data::tftp_server_port
  } else {
    $tftp_server_port = '69'
  } # fi

  if $common::data::tftp_server_binary {
    $tftp_server_binary = $common::data::tftp_server_binary
  } else {
    $tftp_server_binary = '/usr/sbin/in.tftpd'
  } # fi

  if $common::data::tftp_server_args {
    $tftp_server_args = $common::data::tftp_server_args
  } elsif $common::data::tftp_server_base_dir {
    $tftp_server_args = "-s ${common::data::tftp_server_base_dir}"
  } else {
    $tftp_server_args = "-s ${tftp_server_base_dir}"
  } # fi

  if $common::data::tftp_server_socket_type {
    $tftp_server_socket_type = $common::data::tftp_server_socket_type
  } else {
    $tftp_server_socket_type = 'dgram'
  } # fi

  if $common::data::tftp_server_protocol {
    $tftp_server_protocol = $common::data::tftp_server_protocol
  } else {
    $tftp_server_protocol = 'udp'
  } # fi

  if $common::data::tftp_server_cps {
    $tftp_server_cps = $common::data::tftp_server_cps
  } else {
    $tftp_server_cps = '100 2'
  } # fi

  if $common::data::tftp_server_per_source {
    $tftp_server_per_source = $common::data::tftp_server_per_source
  } else {
    $tftp_server_per_source = '11'
  } # fi
} # class tftp::data
