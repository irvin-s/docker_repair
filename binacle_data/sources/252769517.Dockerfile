FROM debian:stable  
  
RUN \  
DEBIAN_FRONTEND=noninteractive \  
apt-get -y -q update \  
&& apt-get -y -q --no-install-recommends install \  
memcached \  
gosu \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm /var/log/dpkg.log  
  
EXPOSE 11211  
ENV LANG=C  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["memcached"]  

