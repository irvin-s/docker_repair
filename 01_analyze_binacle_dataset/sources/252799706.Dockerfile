FROM debian:jessie  
  
MAINTAINER "Diego Marangoni" <diegomarangoni@me.com>  
  
ENV KIBANA_BRANCH master  
  
RUN apt-get update \  
&& apt-get install -y nodejs nodejs-legacy npm git zip \  
&& npm install -g grunt-cli bower  
  
RUN git clone https://github.com/elastic/kibana.git /tmp/kibana \  
&& cd /tmp/kibana \  
&& git checkout $KIBANA_BRANCH \  
&& npm install \  
&& bower --allow-root --config.interactive=false install \  
&& grunt build  
  
RUN cd /tmp/kibana/target \  
&& uname -m | grep -ciq 'x86_64' && ARCH="x64" || ARCH="x86" \  
&& tar zxf kibana-*-linux-$ARCH.tar.gz \  
&& mv kibana-*-linux-$ARCH /opt/kibana \  
&& cd /opt/kibana \  
&& rm -rf /tmp/kibana  
  
EXPOSE 5601  
CMD ["/opt/kibana/bin/kibana"]  

