FROM kalilinux/kali-linux-docker  
  
LABEL maintainer "Benjamin Stein <info@diffus.org>"  
  
RUN apt-get -y update && apt-get install -y \  
kali-linux-full \  
\--no-install-recommends && \  
rm -rf /var/lib/apt/lists/*  
  
CMD ["/bin/bash"]  

