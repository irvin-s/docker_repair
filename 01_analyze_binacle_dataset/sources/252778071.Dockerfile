from alpine:latest  
  
ENV WP_VERSION master  
  
ADD https://github.com/WordPress/WordPress/archive/${WP_VERSION}.zip /src.zip  
RUN unzip -q src.zip && mv /WordPress-${WP_VERSION} /src  
  
VOLUME ["/src"]  
  
CMD /bin/sh  

