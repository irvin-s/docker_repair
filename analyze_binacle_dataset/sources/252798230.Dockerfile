FROM deliverous/wheezy  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN sed -e 's/wheezy/jessie/g' -i /etc/apt/sources.list \  
&& apt-get update \  
&& apt-get install -y sysvinit-core \  
&& apt-get dist-upgrade -y \  
&& apt-get autoremove -y \  
&& apt-get clean  

