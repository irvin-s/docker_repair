FROM perl:5.24  
MAINTAINER Avast Viruslab Systems  
  
RUN cpanm -v App::opan  
  
VOLUME ["/opan"]  
WORKDIR /opan  
  
EXPOSE 8030  
COPY opan_entrypoint.pl /  
  
ENTRYPOINT ["/opan_entrypoint.pl"]  
CMD ["prefork", "-l", "http://0.0.0.0:8030"]  

