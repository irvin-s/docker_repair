FROM ubuntu:14.04  
MAINTAINER Carlos Moro <cmoro@deusto.es>  
  
# Set locales  
RUN locale-gen en_GB.UTF-8  
ENV LANG en_GB.UTF-8  
ENV LC_CTYPE en_GB.UTF-8  
# Fix sh  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
# Install dependencies  
RUN apt-get update  
RUN apt-get install -y git build-essential curl wget libpcap-dev  
  
# Clone masscan git repo  
RUN git clone https://github.com/robertdavidgraham/masscan /opt/masscan  
WORKDIR /opt/masscan  
  
# Make masscan  
RUN make -j  
  
# Copy binary  
RUN cp /opt/masscan/bin/masscan /usr/local/bin  
  
# Launch Bash  
CMD ["/bin/bash"]  

