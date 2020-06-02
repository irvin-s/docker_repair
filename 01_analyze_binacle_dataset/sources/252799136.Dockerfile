FROM dexec/base-mono:1.0.1  
MAINTAINER andystanton  
ADD image-common /tmp/dexec/image-common  
VOLUME /tmp/dexec/build  
ENTRYPOINT ["/tmp/dexec/image-common/dexec-mono-family.sh", "mcs", "-out:"]  

