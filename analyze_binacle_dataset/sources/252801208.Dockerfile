FROM selenium/standalone-chrome:3.4.0  
USER root  
  
# =========================================================================  
# Install NodeJS  
# gpg keys listed at https://github.com/nodejs/node  
# =========================================================================  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
curl \  
build-essential \  
rsync \  
ruby \  
ruby-dev \  
ruby-sass \  
netcat-openbsd && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install -y --force-yes --no-install-recommends \  
nodejs  
  
# =========================================================================  
# Install Ruby Gems  
# =========================================================================  
RUN gem install bundler --no-ri --no-rdoc  
  
RUN apt-get autoremove -y --purge ruby-dev && \  
apt-get clean all && \  
rm -rf /var/lib/apt/lists/*  
  
# Expose ports.  
EXPOSE 5901  
CMD ["/opt/bin/entry_point.sh"]  

