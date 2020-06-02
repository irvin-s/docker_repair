FROM ruby:2.5-alpine  
MAINTAINER cnosuke  
  
RUN apk update \  
&& apk add --no-cache bash openssh \  
&& mkdir -p /staff/.ssh/ /setup \  
&& touch /staff/.ssh/authorized_keys \  
&& adduser -D -h /staff staff \  
&& passwd -u staff \  
&& chown staff:staff /staff/.ssh/authorized_keys  
  
ADD . /setup  
WORKDIR /setup  
  
ENV HOST_KEYS /host_keys  
ENV SSH_PORT 22  
EXPOSE 22  
CMD ["./run.sh"]  

