# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Mike Adolphs <mike@fooforge.com>

# Install dependencies
RUN /usr/bin/apt-get update
RUN /usr/bin/apt-get install -qy build-essential cron curl git libicu-dev libreadline-dev libssl-dev libxml2-dev libxslt-dev libyaml-dev openssh-client zlib1g-dev

# Add github.com to known_hosts
RUN /bin/mkdir /root/.ssh
RUN /usr/bin/ssh-keyscan -H github.com >> /root/.ssh/known_hosts

# Install rbenv/Ruby
RUN /usr/bin/git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN /usr/bin/git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh

ENV PATH /root/.rbenv/bin:$PATH
RUN /bin/echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN /bin/echo 'eval "$(rbenv init -)"' >> .bashrc

ENV CONFIGURE_OPTS --disable-install-doc
RUN /bin/bash -c 'rbenv install 2.0.0-p353'
RUN /bin/bash -c 'rbenv global 2.0.0-p353'
RUN /bin/bash -c 'rbenv rehash'

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN /bin/bash -lc 'gem install bundler'

# Add deploy_key and SSH config for docker-gollum
ADD .docker/ssh_id_rsa /root/.ssh/id_rsa
ADD .docker/ssh_config /root/.ssh/config
RUN /bin/chown -R root:root /root/.ssh
RUN /bin/chmod 0400 /root/.ssh/id_rsa
RUN /bin/chmod 0400 /root/.ssh/config

# Add gitconfig, crontab and run script
ADD .docker/gitconfig /root/.gitconfig
ADD .docker/crontab /root/crontab
RUN crontab /root/crontab
ADD .docker/run.sh /root/run.sh
ADD .docker/update_repo.sh /root/update_repo.sh

# Clone and build docker-gollum
RUN /usr/bin/git clone git@github.com:[username]/docker-gollum.git /var/www/docker-gollum/
RUN /bin/bash -lc 'cd /var/www/docker-gollum; bundle'

EXPOSE 80

# Start docker-gollum
CMD ["/bin/bash", "/root/run.sh"]
