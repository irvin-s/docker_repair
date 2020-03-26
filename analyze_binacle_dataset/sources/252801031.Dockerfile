FROM progrium/buildstep:latest  
MAINTAINER Eric <edonaldson@draconrose.com>  
  
USER root  
  
ADD run.sh /run.sh  
RUN rm -fr /app  
  
ONBUILD ADD . /app  
ONBUILD RUN /build/builder  
  
ENTRYPOINT ["/run.sh"]  
CMD ["/start","web"]  

