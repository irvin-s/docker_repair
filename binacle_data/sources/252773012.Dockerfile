FROM debian:jessie  
MAINTAINER Quentin Devos <quentin@qdevos.eu>  
  
ENV maildomain mail.example.org  
ENV domain example.org  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get install -y --no-install-recommends \  
opendkim \  
opendkim-tools \  
openssl \  
rsyslog \  
&& rm -rf /var/lib/apt/lists/*  
  
VOLUME ["/etc/opendkim"]  
  
COPY ./opendkim.conf.append opendkim.conf.append  
RUN cat opendkim.conf.append >> /etc/opendkim.conf \  
&& rm opendkim.conf.append  
  
COPY ./entrypoint.sh /entrypoint.sh  
  
EXPOSE 12301  
ENTRYPOINT [ "/entrypoint.sh" ]  
CMD ["tail"]

