FROM debian:stretch-slim  
LABEL maintainer="matthias.loeffel@gmail.com <Matthias Löffel>"  
  
ENV DEBIAN_FRONTEND=noninteractive  
RUN apt-get update \  
&& apt-get install -y libxml2-utils bash curl \  
&& apt-get clean \  
&& apt-get autoclean \  
&& mkdir -p /opt/urbanterror \  
  
WORKDIR /opt/urbanterror  
ADD install.sh .  
RUN ["bash", "install.sh"]  
CMD ["./Quake3-UrT-Ded.x86_64"]  
EXPOSE 27960  

