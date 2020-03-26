FROM firehol/netdata:alpine  
  
CMD ["/netdata.sh"]  
  
WORKDIR /etc/netdata  
  
COPY ["netdata.sh", "*.ini", "*.conf", "/etc/netdata/overrides/"]  
  
RUN \  
apk --no-cache add \  
ca-certificates \  
py-pip \  
bash \  
nodejs-npm \  
&& \  
ln -sf /bin/bash /bin/sh && \  
# Install crudini (not available as alpine pkg)  
pip install --no-cache-dir crudini && \  
# Install merge-yaml-cli  
npm install -g merge-yaml-cli && \  
# Cleanup  
apk del py-pip nodejs-npm && \  
# Prepare scripts  
mv overrides/netdata.sh / && \  
chmod +x /netdata.sh /usr/bin/crudini && \  
mkdir -p /etc/netdata/post-start.d /etc/netdata/pre-start.d && \  
# Apply config  
mv overrides/stream.conf /etc/netdata/ && \  
crudini --inplace --merge netdata.conf < overrides/netdata.ini && \  
cp overrides/stream.ini overrides/netdata.ini  
  
COPY ["pre-start.d/*.sh", "/etc/netdata/pre-start.d/"]  
  
ENV \  
N_ENABLE_WEB="no" \  
N_ENABLE_PYTHON_D="no" \  
N_ENABLE_NODE_D="no" \  
N_MEMORY_MODE="save"\  
N_STREAM_MASTER_HEALTH="auto"  

