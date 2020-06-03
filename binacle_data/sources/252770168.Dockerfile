FROM progrium/buildstep:latest  
MAINTAINER Devin Smith <docker@arzynik.com>  
  
USER root  
  
ADD run.sh /run.sh  
RUN rm -fr /app  
  
ONBUILD ADD . /app  
ONBUILD RUN /build/builder  
  
ENTRYPOINT ["/run.sh"]  
CMD ["/start","web"]  

