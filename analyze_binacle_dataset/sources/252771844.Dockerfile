FROM tomcat:8.0-jre8  
  
LABEL maintainer="martynas@atomgraph.com"  
  
RUN apt-get update && \  
apt-get -y install xsltproc  
  
# USER tomcat  
WORKDIR $CATALINA_HOME  
  
ENV HTTP_PORT=8080  
ENV HTTP_PROXY_NAME=  
  
ENV HTTP_PROXY_PORT=  
  
ENV HTTP_REDIRECT_PORT=  
  
ENV HTTP_CONNECTION_TIMEOUT=20000  
ENV HTTPS_PORT=8443  
ENV HTTPS_MAX_THREADS=150  
ENV HTTPS_CLIENT_AUTH=  
  
ENV HTTPS_PROXY_NAME=  
  
ENV HTTPS_PROXY_PORT=  
  
ENV JKS_FILE=letsencrypt.jks  
  
ENV JKS_KEY_PASSWORD=  
  
ENV KEY_ALIAS=letsencrypt  
  
ENV JKS_STORE_PASSWORD=  
  
ENV P12_FILE=letsencrypt.p12  
  
# add XSLT stylesheet that makes changes to server.xml  
COPY letsencrypt-tomcat.xsl conf/letsencrypt-tomcat.xsl  
  
# add entrypoint  
COPY entrypoint.sh entrypoint.sh  
  
EXPOSE $HTTP_PORT $HTTPS_PORT  
  
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]

