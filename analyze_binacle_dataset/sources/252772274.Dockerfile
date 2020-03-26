FROM avastsoftware/cpanm:latest  
  
MAINTAINER Avast Viruslab Systems  
  
COPY cpanfile /install/cpanfile  
RUN cpanm --installdeps /install  
COPY . /install  
RUN cpanm /install  
  
ENTRYPOINT ["deploy"]  

