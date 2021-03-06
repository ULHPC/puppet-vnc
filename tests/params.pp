# File::      <tt>params.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2016 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include 'vnc::params'

$names = ['ensure', 'configpath', 'configuser', 'protocol', 'port', 'packagename', 'environment_packages']

notice("vnc::params::ensure = ${vnc::params::ensure}")
notice("vnc::params::configpath = ${vnc::params::configpath}")
notice("vnc::params::configuser = ${vnc::params::configuser}")
notice("vnc::params::protocol = ${vnc::params::protocol}")
notice("vnc::params::port = ${vnc::params::port}")
notice("vnc::params::packagename = ${vnc::params::packagename}")
notice("vnc::params::environment_packages = ${vnc::params::environment_packages}")

#each($names) |$v| {
#    $var = "vnc::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
