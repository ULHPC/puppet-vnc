# File::      <tt>debian.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: vnc::debian
#
# Specialization class for Debian systems
class vnc::debian inherits vnc::common {

  exec { 'apt-update':
    command => '/usr/bin/apt-get update',
  }

  package { $vnc::params::environment_packages :
      ensure  => $vnc::ensure,
      require => Exec['apt-update'],
  }

}
