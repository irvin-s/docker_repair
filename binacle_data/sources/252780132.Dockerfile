FROM alpine:edge  
  
RUN ["apk", "add", "-U", "git", "ca-certificates", "go", "make"]  
  
COPY . /go/src/ngrok  
WORKDIR /go/src/ngrok  
  
RUN ["make", "release-server"]  
  
ENV TLS_KEY=**None** \  
TLS_CERT=**None** \  
CA_CERT=**None** \  
DOMAIN=**None** \  
TUNNEL_ADDR=:4443 \  
HTTP_ADDR=:80 \  
HTTPS_ADDR=:443 \  
AUTH_TOKEN=**None**  
  
ENTRYPOINT ["/go/src/ngrok/entrypoint.sh"]  
  
CMD exec ngrokd -tlsKey=/server.key -tlsCrt=/server.crt \  
-domain="${DOMAIN}" \  
-httpAddr="${HTTP_ADDR}" -httpsAddr="${HTTPS_ADDR}" \  
-tunnelAddr="${TUNNEL_ADDR}" -authtoken="${AUTH_TOKEN}"  

