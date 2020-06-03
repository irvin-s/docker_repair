from puppet

maintainer Dan Drown <dan@drown.org>

run yum -y install wget tar
run git clone https://github.com/ddrown/puppet-android-cross-compile.git /var/lib/puppet
run /var/lib/puppet/run
