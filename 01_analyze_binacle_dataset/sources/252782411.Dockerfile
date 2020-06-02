FROM debian:testing  
MAINTAINER swisstengu <tengu@tengu.ch>  
  
RUN apt update && apt-get upgrade -y  
  
RUN apt install -y perl  
RUN apt install -y libcatalyst-perl libcatalyst-modules-extra-perl  
RUN apt install -y libcatalyst-devel-perl \  
libcatalyst-view-tt-perl \  
libcatalyst-action-renderview-perl \  
libcatalyst-plugin-configloader-perl \  
libcatalyst-plugin-static-simple-perl \  
libcatalyst-model-dbic-schema-perl \  
libcatalyst-plugin-session-state-cookie-perl \  
libcatalyst-plugin-session-store-file-perl \  
libcatalyst-plugin-authentication-perl \  
libcatalyst-view-json-perl \  
libmath-round-perl \  
libcatalyst-plugin-cache-perl \  
libfile-cache-perl \  
libnet-amazon-s3-perl \  
libcrypt-cbc-perl \  
liblocal-lib-perl \  
libmodule-install-perl \  
sendmail \  
build-essential  
  
RUN apt clean all  
  
COPY entrypoint /entrypoint  
COPY entrypoint.debug /entrypoint.debug  
RUN chmod +x /entrypoint*  
COPY entrypoint.d/* /entrypoint.d/  
RUN chmod +x /entrypoint.d/*  
RUN useradd -d /webapp --uid 1024 catalyst  
USER catalyst  
CMD ["/entrypoint"]  

