# phusion passenger docker is a minimal distro based on ubuntu with nice  
# docker-related features  
FROM phusion/baseimage:0.9.19  
ENV HOME /root  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"  
RUN apt-get install -y zip python nodejs python-pip  
RUN pip install --upgrade pip  
  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

