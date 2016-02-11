# File::      <tt>vnc.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: vnc
#
# Configure and manage vnc
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of vnc
#
# == Actions:
#
# Install and configure vnc
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     import vnc
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'vnc':
#             ensure     => 'present',
#             configpath => '/var/lib/localadmin',
#             configuser => 'localadmin'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class vnc(
    $ensure     = $vnc::params::ensure,
    $configpath = $vnc::params::configpath,
    $configuser = $vnc::params::configuser
)
inherits vnc::params
{
    info ("Configuring vnc (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("vnc 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include vnc::debian }
        redhat, fedora, centos: { include vnc::redhat }
        default: {
            fail("Module $module_name is not supported on $operatingsystem")
        }
    }
}

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
        name    => $vnc::params::packagename,
        ensure  => $vnc::ensure,
    }

    file { "${vnc::configpath}/.vnc":
        ensure  => 'directory',
        mode    => '0755',
        owner   => $vnc::configuser,
    } ->
    file { "${vnc::configpath}/.vnc/xstartup":
        ensure  => $vnc::ensure,
        mode    => '0755',
        source  => 'puppet:///modules/vnc/xstartup',
    }

    package { $vnc::params::environment_packages :
        ensure  => $vnc::ensure,
    }

}


# ------------------------------------------------------------------------------
# = Class: vnc::debian
#
# Specialization class for Debian systems
class vnc::debian inherits vnc::common { }

# ------------------------------------------------------------------------------
# = Class: vnc::redhat
#
# Specialization class for Redhat systems
class vnc::redhat inherits vnc::common { }



