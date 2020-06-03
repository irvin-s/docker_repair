FROM balasys/zorpgpl  
  
MAINTAINER Szilárd Pfeiffer "coroner@pfeifferszilard.hu"  
RUN apt-get update  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \  
openssl \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD policy.py $ZORP_CONFIG_DIR/policy.py  
  
COPY . /app/  
  
EXPOSE 443  

