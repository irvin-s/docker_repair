
FROM dmouse/puphpet

MAINTAINER David Flores "dmousex@gmail.com"

ADD ./ /vagrant

RUN /vagrant/puphpet/shell/initial-setup.sh "/vagrant/puphpet"
RUN /vagrant/puphpet/shell/update-puppet.sh
RUN /vagrant/puphpet/shell/r10k.sh

RUN puppet apply /vagrant/puphpet/puppet/manifest.pp --hiera_config /vagrant/puphpet/puppet/hiera.yaml --verbose --parser future

RUN /vagrant/puphpet/shell/execute-files.sh
