FROM daprlabs/archlinux  
MAINTAINER Reuben Bond, reuben.bond@gmail.com  
  
# Install JDK and clean the package cache  
RUN yaourt --noconfirm -Syy jdk; pacman -Scc  
  
# Configure the environment  
ENV PATH $PATH:/opt/java/bin  
ENV JAVA_HOME /opt/java

