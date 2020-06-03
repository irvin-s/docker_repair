###########################################################  
# Dockerfile to build container image of Puppet  
# Based on Ubuntu  
############################################################  
  
# Set the base image to Ubuntu  
FROM ubuntu  
  
# File Author / Maintainer  
MAINTAINER RajithaK (rajithak@brandix.com)  
  
WORKDIR /tmp  
  
# Update the repository sources list  
RUN apt-get update  
  
# Install Puppet Master Server  
  
RUN apt-get install -y wget && \  
apt-get install -y elinks && \  
apt-get install -y nano && \  
apt-get install -y telnet && \  
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb &&\  
dpkg -i puppetlabs-release-trusty.deb &&\  
apt-get update &&\  
apt-get install -y puppetmaster-passenger &&\  
service apache2 stop &&\  
rm -rf ./puppetlabs-release-trusty.deb  
  
# Set Puppet Configuration  
ADD 00-puppet.pref /etc/apt/preferences.d/  
  
RUN mv /etc/puppet/puppet.conf /etc/puppet/puppet.conf_backUp &&\  
rm -rf /etc/apache2/sites-enabled/puppetmaster.conf  
  
ADD puppet.conf /etc/puppet/  
ADD puppetmaster.conf /etc/apache2/sites-enabled/  
RUN chmod 777 /etc/apache2/sites-enabled/puppetmaster.conf  
  
# Set Pupper Certificates  
RUN rm -rf /var/lib/puppet/ssl &&\  
puppet master --verbose &&\  
touch /etc/puppet/manifests/site.pp  
  
EXPOSE 8041 443 61613 80 3000 3306  
  
# Install Puppet Dashboard  
  
# Install Ruby  
  
RUN apt-get install -y git &&\  
apt-get install -y build-essential &&\  
apt-get install -y ruby-full &&\  
echo "gem: --no-ri --no-rdoc" > ~/.gemrc &&\  
gem install bundler  
  
# Install MySQL  
  
RUN apt-get install -y mysql-server-5.6  
  
# Install Puppet Dashboard  
  
WORKDIR /opt  
  
RUN git clone https://github.com/sodabrew/puppet-dashboard.git  
  
ADD database.yml /opt/puppet-dashboard/config/  
ADD settings.yml /opt/puppet-dashboard/config/  
  
RUN cd /opt/puppet-dashboard/ &&\  
apt-get install -y libmysqlclient-dev &&\  
apt-get install -y libxslt-dev libxml2-dev &&\  
apt-get install -y libpq-dev &&\  
apt-get install -y libsqlite3-dev &&\  
apt-get install -y nodejs &&\  
bundle install --deployment &&\  
echo "secret_token: '$(bundle exec rake secret)'" >> config/settings.yml  
  
WORKDIR /opt/puppet-dashboard/  
  
RUN service mysql start &&\  
mysql -u root -e "create database puppet" &&\  
bundle exec rake db:setup &&\  
mv /etc/bash.bashrc /etc/bash.bashrc.backup &&\  
mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup  
  
ADD bash.bashrc /etc/  
ADD apache2.conf /etc/apache2/  
RUN chmod 644 /etc/bash.bashrc &&\  
chmod 644 /etc/apache2/apache2.conf  

