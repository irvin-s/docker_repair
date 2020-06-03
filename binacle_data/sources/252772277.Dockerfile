FROM avastsoftware/opan  
  
MAINTAINER Avast Viruslab Systems  
  
COPY cpanfile /tmp/cpanfile  
RUN cpanm --installdeps /tmp; rm /tmp/cpanfile  
  
EXPOSE 8081  
COPY opan_uploader /usr/bin/opan_uploader  
  
ENTRYPOINT ["hypnotoad"]  
CMD ["-f", "/usr/bin/opan_uploader"]  

