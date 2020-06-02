FROM ubuntu:latest  
MAINTAINER 3bch  
  
# Update Packages  
RUN apt-get update  
  
# Install Utils  
RUN apt-get install -y curl wget less lv unzip zip xz-utils tzdata  
  
# Install Dev Tools  
RUN apt-get install -y vim zsh git editorconfig  
COPY ./config/* /root/  
  
# Setup Locale  
ENV LANG=C.UTF-8 \  
LC_ALL=C.UTF-8  
# Setup TimeZone  
ENV TZ=Asia/Tokyo  
RUN dpkg-reconfigure -f noninteractive tzdata  
  
# Boot Settings  
WORKDIR /root  
CMD ["/usr/bin/zsh"]  
  

