FROM haproxy:1.5  
COPY haproxy.cfg /haproxy.cfg  
  
RUN set -x \  
&& DEBIAN_FRONTEND="noninteractive" \  
&& RUNTMDEPS="perl supervisor openssl" \  
&& apt-get --quiet --yes update \  
&& apt-get --quiet --yes install --no-install-recommends ${RUNTMDEPS} \  
&& apt-get --quiet --yes autoclean \  
&& apt-get --quiet --yes autoremove \  
&& apt-get --quiet --yes clean  
  
# prepare content  
COPY ipUpdate-1.6 /ipUpdate-1.6/  
COPY install.conf /etc/supervisor/conf.d/  
COPY run.conf /  
COPY run_once.sh /  
RUN chmod +x /run_once.sh  
COPY ipUpdate-monitor.sh /  
RUN chmod +x /ipUpdate-monitor.sh  
RUN chmod +x /ipUpdate-1.6/ipUpdate.pl  
RUN chmod +x /ipUpdate-1.6/setup.pl  
RUN mv ipUpdate-1.6/Http_get.pm /usr/share/perl5/  
  
# expose http ports managed by haproxy  
EXPOSE 80 443  
# expose stats port of haproxy  
EXPOSE 1936  
# ENV vars for openssl cert generation  
ENV COUNTRY YC  
ENV STATE your_state  
ENV LOCATION your_location  
ENV ORGANIZATION your_organization  
ENV UNIT your_organizational_unit  
ENV COMMON_NAME your_common_name  
  
# Authorization of user of Supervisor web interface  
ENV USER user  
ENV PASSWORD 123-  
  
# run  
CMD ["sh","-c","/usr/bin/supervisord"]  

