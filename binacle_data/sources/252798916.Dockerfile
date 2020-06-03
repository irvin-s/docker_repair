FROM golang:latest  
MAINTAINER Chase Sillevis <chase@sillevis.net>  
  
# When this Dockerfile was last refreshed (year/month/day)  
ENV REFRESHED_AT 2016-11-03  
ENV OAUTH2_PROXY_VERSION 2.1  
# Checkout bitly's latest google-auth-proxy code from Github  
ADD https://github.com/DeviaVir/oauth2_proxy/archive/v2.1.1.tar.gz /tmp  
RUN cd /tmp && \  
tar -xf /tmp/v2.1.1.tar.gz && \  
rm /tmp/*.tar.gz && \  
cd /tmp/oauth2_proxy-2.1.1 && \  
wget https://raw.githubusercontent.com/pote/gpm/v1.3.2/bin/gpm && \  
chmod +x gpm && \  
./gpm install && \  
go get github.com/bitly/oauth2_proxy/cookie && \  
go get github.com/bitly/oauth2_proxy/providers && \  
go get github.com/gorilla/websocket && \  
go get cloud.google.com/go/compute/metadata && \  
go build && \  
mv oauth2_proxy-2.1.1 /bin/oauth2_proxy && \  
chmod +x /bin/oauth2_proxy && \  
cd /  
  
# Expose the ports we need and setup the ENTRYPOINT w/ the default argument  
# to be pass in.  
EXPOSE 8080 4180  
ENTRYPOINT [ "/bin/oauth2_proxy" ]  
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]  

