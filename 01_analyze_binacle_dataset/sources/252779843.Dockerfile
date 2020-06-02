FROM openjdk:8-jdk  
MAINTAINER Conmio developers  
RUN apt-get update && apt-get install -y curl git build-essential \  
&& git clone https://github.com/ncopa/su-exec.git /tmp/su-exec \  
&& cd /tmp/su-exec \  
&& make \  
&& chmod 770 su-exec \  
&& mv ./su-exec /usr/local/sbin/ \  
&& apt-get remove -y git build-essential \  
&& apt-get autoremove -y \  
&& apt-get clean \  
&& apt-get autoclean \  
&& rm -rf /var/lib/{apt,dpkg,cache,log}/  
  
COPY script/entrypoint.sh /usr/local/bin/entrypoint.sh  
RUN chmod 755 /usr/local/bin/entrypoint.sh  
  
WORKDIR /app  
  
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]  

