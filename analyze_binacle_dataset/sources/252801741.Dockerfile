FROM alpine:3.4  
  
ENV LANG C  
  
RUN apk add \--no-cache curl bash git mercurial openssh perl  
  
COPY config /root/.ssh/config  
RUN chmod 0600 /root/.ssh/config  
  
COPY hgrc /usr/etc/mercurial/hgrc  
  
ADD assets/ /opt/resource/  
RUN chmod +x /opt/resource/*

