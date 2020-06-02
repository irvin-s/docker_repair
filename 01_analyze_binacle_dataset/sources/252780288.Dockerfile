FROM busybox:ubuntu-14.04  
MAINTAINER Azuki <support@azukiapp.com>  
  
ENV NGROK_VERSION 2.0.19  
# Install ngrok  
ADD https://dl.ngrok.com/ngrok_${NGROK_VERSION}_linux_amd64.zip ngrok.zip  
RUN unzip ngrok.zip -d /bin \  
&& rm -f ngrok.zip \  
&& mkdir -p /ngrok/log \  
&& echo 'web_addr: 0.0.0.0:4040' > /ngrok/ngrok.yml  
  
EXPOSE 4040  
#Add config script  
ADD ngrok_discover /bin/ngrok_discover  
RUN chmod +x /bin/ngrok_discover  
  
CMD ["/bin/ngrok_discover"]  

