FROM accur8/a8_base_image:latest  
  
MAINTAINER Accur8 Software "https://github.com/accur8"  
RUN \  
add-apt-repository ppa:haxe/releases -y && \  
apt-add-repository -y ppa:andrei-pozolotin/maven3 && \  
apt-get update && \  
apt-get install -y haxe maven3 && \  
mkdir ~/haxelib && haxelib setup ~/haxelib  
  
RUN mkdir -p /usr/local/_packages  
  
WORKDIR /usr/local/_packages  
  
RUN \  
wget http://downloads.typesafe.com/zinc/0.3.7/zinc-0.3.7.tgz && \  
tar xf zinc-0.3.7.tgz && \  
rm zinc-0.3.7.tgz  
  
ENV PATH /usr/local/_packages/zinc-0.3.7/bin:$PATH  
  
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/  
  
WORKDIR /root/  
  
COPY image/ /  
  
CMD ["/sbin/my_init"]  
  
# == build with ==  
#  
# docker build -t a8_dev .  

