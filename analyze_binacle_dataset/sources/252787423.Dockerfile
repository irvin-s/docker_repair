FROM brimstone/ubuntu:14.04  
# Clear our cmd args  
CMD []  
  
# Set our entrypoint  
ENTRYPOINT ["/loader"]  
  
# Expose rsync and apache  
EXPOSE 873 80  
# Set our volume as exportable, if that's a thing  
VOLUME /mirror/pool  
  
# Add our packages  
RUN apt-get update \  
&& apt -y install rsync dpkg-dev apache2 \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists \  
&& a2dissite 000-default.conf \  
&& mkdir /run/lock \  
&& chmod 777 /run/lock  
  
# Add out apache config file  
# Not debian kosher, but whatev  
ADD mirror.conf /etc/apache2/sites-enabled/mirror.conf  
  
# Add our rsync config file  
ADD rsyncd.conf /etc/rsyncd.conf  
  
# Add our loader script  
ADD loader /loader  
  
# Add our Packages fixup script  
ADD dpkg-fixup /dpkg-fixup  

