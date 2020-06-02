FROM dckreg:5000/openjdk:8-jdk

ENV PATH $PATH:/opt/node/bin
RUN wget https://nodejs.org/dist/v6.9.0/node-v6.9.0-linux-x64.tar.gz
RUN tar xvf node-v6.9.0-linux-x64.tar.gz
RUN rm node-v6.9.0-linux-x64.tar.gz
RUN mv  node-v6.9.0-linux-x64 /opt/node
RUN apt-get install -y  build-essential
RUN apt-get install -y libsasl2-dev
COPY app /app
WORKDIR /app
RUN npm install node-rdkafka 
RUN npm install
