FROM frolvlad/alpine-glibc:alpine-3.6  
  
RUN ZULU_VERSION="7.18.0.3-jdk7.0.141" \  
&& ZULU_ARCHIVE_NAME="zulu${ZULU_VERSION}-linux_x64" \  
&& apk add --no-cache \  
\--virtual=.build-dependencies \  
ca-certificates \  
curl \  
&& curl -fSL \  
"https://cdn.azul.com/zulu/bin/${ZULU_ARCHIVE_NAME}.tar.gz" \  
-o "/tmp/${ZULU_ARCHIVE_NAME}.tar.gz" \  
&& mkdir -p /opt \  
&& tar xzf "/tmp/${ZULU_ARCHIVE_NAME}.tar.gz" -C /opt \  
&& rm -f "/tmp/${ZULU_ARCHIVE_NAME}.tar.gz" \  
&& mv "/opt/${ZULU_ARCHIVE_NAME}" /opt/zulu \  
&& chown -R root:root /opt/zulu \  
&& rm -rf /opt/zulu/demo \  
/opt/zulu/man \  
/opt/zulu/sample \  
/opt/zulu/src.zip \  
&& echo 'export JAVA_HOME=/opt/zulu' > /etc/profile.d/zulu.sh \  
&& echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile.d/zulu.sh \  
&& apk del .build-dependencies  
  
ENV JAVA_HOME /opt/zulu  
ENV PATH ${PATH}:${JAVA_HOME}/bin  

