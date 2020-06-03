FROM bigbrozer/x2go-base  
  
LABEL authors="Vincent BESANCON <besancon.vincent@gmail.com>"  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install KDE suite  
RUN set -x \  
&& apt-get update -y \  
&& apt-get install -y plasma-desktop \  
&& rm -rf /var/lib/apt/lists/*  
  
# Run it  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D"]  

