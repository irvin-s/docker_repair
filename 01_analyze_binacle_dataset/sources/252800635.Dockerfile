# Run flamerobin in a container  
# docker run -it \  
# --rm \  
# -e DISPLAY=192.168.65.1:0  
# --name flamerobin donnykurnia/flamerobin  
FROM ubuntu:14.04  
MAINTAINER Donny Kurnia <donnykurnia@gmail.com>  
  
RUN apt-get update && apt-get install -y flamerobin  
  
RUN mkdir /root/.flamerobin  
COPY fr_databases.conf fr_settings.conf /root/.flamerobin/  
COPY local.conf /etc/fonts/local.conf  
  
ENTRYPOINT [ "flamerobin" ]  

