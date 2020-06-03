FROM debian:jessie  
MAINTAINER Tim Bennett  
  
# Setup Git  
RUN \  
apt-get update && \  
apt-get install -y git-core  
  
# Clean up  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENV THEMES_LOCATION "/var/lib/ghost/themes"  
COPY entrypoint.sh /bin/ghost-themer.sh  
RUN chmod +x /bin/ghost-themer.sh  
  
ENTRYPOINT ["/bin/ghost-themer.sh"]  
  
# Themes to install/update are in the form 'theme:githubrepo'  
CMD ["casper:TryGhost/Casper"]

