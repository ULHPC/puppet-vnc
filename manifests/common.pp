# File::      <tt>common.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: vnc::common
#
# Base class to be inherited by the other vnc classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class vnc::common {

    # Load the variables used in this module. Check the vnc-params.pp file
    require vnc::params

    package { 'vnc':
        ensure => $vnc::ensure,
        name   => $vnc::params::packagename,
    }

    file { "${vnc::configpath}/.vnc":
        ensure => 'directory',
        mode   => '0755',
        owner  => $vnc::configuser,
    } ->
    file { "${vnc::configpath}/.vnc/xstartup":
        ensure => $vnc::ensure,
        mode   => '0755',
        source => 'puppet:///modules/vnc/xstartup',
    }

}
