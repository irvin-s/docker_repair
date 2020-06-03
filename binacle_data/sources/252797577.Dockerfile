FROM alpine:edge  
  
RUN apk update && apk add -U --no-cache \  
git \  
bash \  
openssh \  
&& rm -rf /var/cache/apk/*  
  
RUN git config --global user.email "trovit-gh@trovit.com" \  
&& git config --global user.name "Trovit Deployer" \  
&& git config --global http.sslVerify false  
  
COPY semantic-version.sh semantic-version.sh  
  
RUN chmod +x semantic-version.sh  

