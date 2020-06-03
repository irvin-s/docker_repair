FROM alpine:latest  
MAINTAINER Alexandre Syenchuk <alexpirine@gmail.com>  
  
RUN apk add --no-cache --update autossh  
RUN mkdir -p /etc/ssh/keys  
RUN chmod go-rwx /etc/ssh/keys  
ADD sshtun/ssh_config /etc/ssh/  
ENTRYPOINT ["autossh", "-M", "0"]  
  
# Metadata  
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \  
org.label-schema.url="https://hub.docker.com/r/alexpirine/sshtun/" \  
org.label-schema.vcs-type="Git"  

