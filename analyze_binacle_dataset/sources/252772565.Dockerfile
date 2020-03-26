FROM ubuntu  
MAINTAINER Benjamin Faal  
  
ENV SHARED_KEY FILL_KEY_IN  
ENV TURN_IP FILL_TURN_IP_IN  
ENV TURN_PORT FILL_TURN_PORT_IN  
  
RUN apt-get update -y  
  
RUN apt-get install -y wget  
  
# Google App Engine and Python 2.7  
ENV GAE_VER 1.9.23  
ENV GAE_ZIP go_appengine_sdk_linux_amd64-$GAE_VER.zip  
  
RUN apt-get update && \  
apt-get install --yes \  
unzip \  
python  
  
ADD https://storage.googleapis.com/appengine-sdks/featured/$GAE_ZIP .  
RUN unzip -q $GAE_ZIP -d /usr/local  
RUN rm $GAE_ZIP  
ENV PATH $PATH:/usr/local/go_appengine/  
  
RUN apt-get install python2.7 python-pil -y  
RUN apt-get install python-webtest -y  
  
# NodeJS  
RUN wget -O nodejs.sh https://deb.nodesource.com/setup_4.x  
RUN chmod +x nodejs.sh  
RUN sh ./nodejs.sh  
  
RUN apt-get install -y nodejs  
  
# symlink nodejs to node  
RUN ln -s -f /usr/bin/nodejs /usr/bin/node  
  
RUN apt-get install -y build-essential  
  
# GIT  
RUN apt-get install -y git  
  
RUN git clone https://github.com/BenjaminFaal/apprtc  
  
EXPOSE 8080  
WORKDIR apprtc  
  
RUN npm install -g npm  
RUN npm install -g grunt-cli  
  
RUN npm install  
RUN grunt build  
  
COPY run.sh /  
  
WORKDIR /  
RUN chmod +x /run.sh  
CMD /run.sh  

