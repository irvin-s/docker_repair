FROM progrium/buildstep  
MAINTAINER 'CenturyLink Labs'  
ADD run.sh /run.sh  
RUN chmod +x /run.sh  
  
ONBUILD RUN mkdir -p /app  
ONBUILD ADD . /app  
ONBUILD RUN /build/builder  
  
ENTRYPOINT ["/run.sh"]  

