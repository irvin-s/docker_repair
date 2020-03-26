FROM ageneau/devel-base:latest  
  
MAINTAINER Sylvain Ageneau <ageneau@gmail.com>  
  
RUN apt-get install -y --no-install-recommends locales sbcl  
RUN apt-get clean && apt-get autoclean  
  
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \  
locale-gen C.UTF-8 && \  
/usr/sbin/update-locale LANG=C.UTF-8  
ENV LC_ALL C.UTF-8  
WORKDIR /project  
  
CMD ["sbcl"]  

