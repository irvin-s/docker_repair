FROM busybox  
MAINTAINER Matthieu Mota <matthieumota@gmail.com>  
  
ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip /  
RUN unzip -o ngrok-stable-linux-amd64.zip -d /bin && \  
rm -f ngrok-stable-linux-amd64.zip  
  
CMD ["/bin/ngrok", "http", "http:80"]

