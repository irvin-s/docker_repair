FROM alpine:edge  
  
ARG JDK_BUILD_VERSION="44"  
ENV JAVA_HOME="/docker-java-home"  
ENV PATH="$JAVA_HOME/bin:${PATH}"  
RUN set -x\  
&& apk add --no-cache --virtual .build\  
curl\  
tar\  
&& curl -o openjdk.tar.gz\  
https://download.java.net/java/early_access/alpine/${JDK_BUILD_VERSION}/binaries/openjdk-10+${JDK_BUILD_VERSION}_linux-x64-musl_bin.tar.gz\  
&& mkdir -p ${JAVA_HOME}\  
&& tar -xzf openjdk.tar.gz -C ${JAVA_HOME} \--strip-components=1\  
&& rm openjdk.tar.gz\  
&& apk del .build  
  
WORKDIR /tmp  
  
ENTRYPOINT ["java"]  
CMD ["-version"]  

