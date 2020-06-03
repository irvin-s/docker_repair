FROM debian:sid  
MAINTAINER Alexandre De Dommelin "adedommelin@tuxz.net"  
# Environment variables  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get install -y locales  
RUN sed -i 's|# en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen  
RUN locale-gen en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  
ENV LC_LANG en_US.UTF-8  
ENV LC_LANGUAGE en_US.UTF-8  
# Download ruby 1.9.3 stuff + install gems  
RUN apt-get install -y ruby1.9.3 make  
RUN /usr/bin/gem1.9.3 install --no-rdoc --no-ri bonsai  
  
# Fix issue with browser loading (thanks @jpetazzo for this one!)  
RUN ln -s /bin/true /usr/bin/firefox  
  
# Add bonsai wrappers  
ADD ./wrappers /usr/local/bin  

