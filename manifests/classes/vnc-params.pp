# File::      <tt>vnc-params.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: vnc::params
#
# In this class are defined as variables values that are used in other
# vnc classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class vnc::params {

    ######## DEFAULTS FOR VARIABLES USERS CAN SET ##########################
    # (Here are set the defaults, provide your custom variables externally)
    # (The default used is in the line with '')
    ###########################################

    # ensure the presence (or absence) of vnc
    $ensure = $vnc_ensure ? {
        ''      => 'present',
        default => "${vnc_ensure}"
    }

    # configuration path of VNC
    $configpath = $vnc_configpath ? {
        ''      => '/var/lib/localadmin/',
        default => "${vnc_configpath}"
    }
    # configuration user of VNC
    $configuser = $vnc_configuser ? {
        ''      => 'localadmin',
        default => "${vnc_configuser}"
    }

    # The Protocol used. Used by monitor and firewall class. Default is 'tcp'
    $protocol = $vnc_protocol ? {
        ''      => 'tcp',
        default => "${vnc_protocol}",
    }
    # The port number. Used by monitor and firewall class. The default is 22.
    $port = $vnc_port ? {
        ''      => 5900,
        default => "${vnc_port}",
    }


    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    # vnc packages
    $packagename = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat)/ => $::lsbmajdistrelease ? {
            '5'     => 'vnc-server',
            default => 'tigervnc-server'
        },
        /(?i-mx:debian|ubuntu)/        => 'vnc4server',
        default                        => 'vnc4server'
    }

    $environment_packages = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat)/ => $::lsbmajdistrelease ? {
            '5'                        => ['firefox', 'xorg-x11-apps', 'icewm', 'icewm-xdgmenu', 'xterm'],
            default                    => ['firefox', 'xorg-x11-apps', 'icewm', 'icewm-xdgmenu', 'xterm']
        },
        'debian'                       => $::lsbmajdistrelease ? {
            '7'                        => ['iceweasel', 'x11-apps', 'icewm', 'xterm'],
            default                    => ['iceweasel', 'x11-apps', 'icewm', 'xterm']
        },
        default                        => ['firefox', 'xorg-x11-apps', 'icewm', 'icewm-xdgmenu', 'xterm']
    }

}

