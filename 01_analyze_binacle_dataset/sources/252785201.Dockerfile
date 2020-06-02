FROM cogniteev/oracle-java:java8  
MAINTAINER Cogniteev <tech@cogniteev.com>  
  
ENV RIEMANN_VERSION=0.2.9  
RUN wget -qO- http://aphyr.com/riemann/riemann-${RIEMANN_VERSION}.tar.bz2 | \  
tar -xjC /usr/share  
  
EXPOSE 5555 5556  
CMD /usr/share/riemann-${RIEMANN_VERSION}/bin/riemann  

