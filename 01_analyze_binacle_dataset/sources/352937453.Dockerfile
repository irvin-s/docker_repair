FROM cfinfrastructure/deployment
MAINTAINER https://github.com/cloudfoundry/mega-ci

# Install vagrant
RUN wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb -P /tmp && \
  dpkg --install /tmp/vagrant_1.8.1_x86_64.deb && \
  vagrant plugin install vagrant-aws && \
  rm -rf /tmp/*
