from centos-epel

maintainer Dan Drown <dan@drown.org>

run yum -y --enablerepo=centosplus install puppet git
run rm -rf /var/lib/puppet
