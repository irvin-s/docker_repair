from centos

maintainer Dan Drown <dan@drown.org>

run yum -y update

run yum -y install https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

run touch /etc/sysconfig/network
