FROM blackikeeagle/alpine:edge  
MAINTAINER Ike Devolder, ike.devolder@gmail.com  
  
ENV C_USER quassel  
  
COPY ./container /container  
RUN /container/install-quassel.sh  
  
ADD ./entrypoint.sh /entrypoint.sh  
  
EXPOSE 4242  
WORKDIR /var/lib/quassel  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["quasselcore", "--configdir=/var/lib/quassel/", "--listen=0.0.0.0"]  

