FROM debian:stretch  
MAINTAINER Damián Silvani <dsilvani@gmail.com>  
  
ENV LANG C.UTF-8  
RUN apt-get update && apt-get install -y --no-install-recommends \  
python3 \  
grass \  
&& rm -rf /var/lib/apt/lists/*  
  
# Externally accessible data is by default put in /data.  
WORKDIR /data  
VOLUME ["/data"]  
  
# Ensure the SHELL is picked up by grass.  
ENV SHELL /bin/bash  
  
# To avoid bug that uses grass70 to check if GRASS is installed...  
RUN ln -s /usr/bin/grass /usr/bin/grass70  
  
# All commands are executed by grass.  
ENTRYPOINT ["grass"]  
  
# Output GRASS version by default.  
CMD ["--help"]  

