FROM kalilinux/kali-linux-docker  
ENV NAME msf  
ENV MSF_UPDATE=1  
WORKDIR /  
VOLUME ["/var/lib/postgresql"]  
VOLUME ["/root"]  
COPY ["./data", "/data"]  
RUN ["/bin/sh", "/data/build.sh"]  
ENTRYPOINT ["/usr/bin/dumb-init", "--"]  
CMD ["/bin/sh", "/data/init.sh"]  
  

