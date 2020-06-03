#  
# Couchbase Test  
#  
FROM couchbase/server:enterprise-5.0.0  
MAINTAINER Corbin Uselton <corbinu@decimal.io>  
  
RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends \  
&& echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \  
&& apt-get update \  
&& apt-get install -y software-properties-common \  
&& add-apt-repository -y ppa:costamagnagianfranco/ettercap-stable-backports \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends curl \  
&& apt-get remove -y software-properties-common \  
&& apt-get autoremove -y  
  
ENV CB_USERNAME Administrator  
ENV CB_PASSWORD administrator  
  
COPY bin/* /usr/local/bin/  
  
EXPOSE 8091 8092 11207 11210 11211 18091 18092  
VOLUME /opt/couchbase/var  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["couchbase-server"]  

