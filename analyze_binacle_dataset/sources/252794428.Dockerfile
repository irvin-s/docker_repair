FROM phusion/passenger-full:0.9.19  
MAINTAINER Martin Fenner "mfenner@datacite.org"  
# Allow app user to read /etc/container_environment  
RUN usermod -a -G docker_env app  
  
# Set correct environment variables  
ENV HOME /home/app  
  
# Use baseimage-docker's init process  
CMD ["/sbin/my_init"]  
  
# Update installed APT packages, clean up when done  
RUN apt-get update && \  
apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Install bundler  
RUN gem install bundler  
  
# Copy webapp folder  
# Install Ruby gems  
ADD . /home/app/webapp  
WORKDIR /home/app/webapp  
RUN mkdir -p /home/app/webapp/vendor/bundle && \  
chown -R app:app /home/app/webapp && \  
chmod -R 755 /home/app/webapp && \  
/sbin/setuser app bundle install --path vendor/bundle  
  
# Add runit script  
RUN mkdir /etc/service/lita  
ADD vendor/docker/lita.sh /etc/service/lita/run  
  
# Expose lita  
EXPOSE 8080  

