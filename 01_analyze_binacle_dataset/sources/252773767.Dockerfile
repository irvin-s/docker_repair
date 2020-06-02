#  
# BrowserStackLocal Dockerfile  
#  
FROM debian:jessie  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update && apt-get install \  
\--no-install-recommends --no-install-suggests -y \  
curl \  
ca-certificates \  
unzip \  
&& export BASE_URL=https://www.browserstack.com/browserstack-local \  
&& cd /tmp && curl -sLO "$BASE_URL"/BrowserStackLocal-linux-x64.zip \  
&& unzip BrowserStackLocal-*.zip && rm BrowserStackLocal-*.zip \  
&& chmod +x BrowserStackLocal && mv BrowserStackLocal /usr/local/bin/ \  
# Remove obsolete dependencies:  
&& apt-get purge -y \  
curl \  
ca-certificates \  
unzip \  
&& apt-get autoremove -y \  
# Remove obsolete files:  
&& apt-get clean \  
&& rm -rf \  
/tmp/* \  
/usr/share/doc/* \  
/var/cache/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
# Add browserstack user+group as a workaround for  
# https://github.com/boot2docker/boot2docker/issues/581  
RUN useradd -u 1000 -m -U browserstack  
  
USER browserstack  
  
WORKDIR /home/browserstack  
  
ENTRYPOINT ["BrowserStackLocal"]  

