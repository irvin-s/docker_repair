# FROM debian:7  
FROM alpine  
  
MAINTAINER Me <andreas.krey@aquilus.com>  
  
# RUN apt-get update && apt-get install -y ssh net-tools  
RUN apk update && apk add openssh  
  
COPY sshd_config /etc/ssh/sshd_config  
  
RUN adduser -g nix -D andrkrey -s /bin/sh -h /ak && mkdir /ak/.ssh  
RUN echo andrkrey:awehduvjs | chpasswd  
COPY auth /ak/.ssh/authorized_keys  
RUN chown -R andrkrey /ak/.ssh  
  
RUN mkdir -p /app  
COPY s.sh /app/  
RUN chmod 755 /app/s.sh  
  
EXPOSE 22  
CMD ["/app/s.sh"]  

