FROM alpine:latest  
ENV NAME sftp  
ENV SSH_USER cornelius  
ENV SSH_UID 1234  
ENV AUTHORIZED_KEYS ""  
ENV SSH_DIRS "in out"  
ENV SSH_DIR_PERM 755  
ENV SSH_DIR_CONT_PERM 644  
WORKDIR /ssh  
COPY ["./ssh", "/ssh"]  
RUN ["/bin/sh", "/ssh/bin/build.sh"]  
EXPOSE 22/tcp  
VOLUME ["/ssh/"]  
ENTRYPOINT ["/usr/bin/dumb-init", "--"]  
CMD ["/bin/sh", "/ssh/bin/init.sh"]  
  

