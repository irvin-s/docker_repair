FROM brimstone/ubuntu:14.04  
  
CMD []  
  
ENTRYPOINT [ "/consul-loader" ]  
  
EXPOSE 8500 8600/udp 8400 8300 8301 8302  
  
RUN package \--list /tmp/dpkg.txt wget unzip \  
&& wget https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip \  
-O /tmp/consul.zip \  
&& unzip /tmp/consul.zip \  
&& rm /tmp/consul.zip \  
&& mv /consul /usr/bin/consul \  
&& wget https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip \  
-O /tmp/consul_webui.zip \  
&& unzip /tmp/consul_webui.zip \  
&& mv /dist /webui \  
&& rm /tmp/consul_webui.zip \  
  
&& package \--purge /tmp/dpkg.txt  
  
ADD consul-loader /  

