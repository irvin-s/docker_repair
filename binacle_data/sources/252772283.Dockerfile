FROM avastsoftware/pinto  
  
MAINTAINER Avast Viruslab Systems  
  
RUN apt-get install -y make cpanminus  
  
COPY cpanfile /tmp/cpanfile  
RUN cpanm --installdeps /tmp  
  
VOLUME ["/var/lib/pinto"]  
EXPOSE 8080  
ENTRYPOINT ["hypnotoad"]  
CMD ["-f", "/usr/bin/pinto_uploader"]  
  
COPY pinto_uploader /usr/bin/pinto_uploader  

