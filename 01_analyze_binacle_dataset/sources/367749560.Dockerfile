# Docker container for https://github.com/lplotni/burstah
#
#  build: docker build -t burstah .
#  run (interactive): docker run -t -i -p 3000:3000 --link gocd-server:gocd_server burstah
#  run (in background): docker run -t -d -p 3000:3000 --link gocd-server:gocd_server burstah
#
#  burstah will be available at http://localhost:3000/

FROM dockerfile/nodejs

RUN curl -O -L https://github.com/lplotni/burstah/archive/master.zip && unzip master.zip && cd burstah-master && npm install
ADD config.js.docker /data/burstah-master/config.js
WORKDIR /data/burstah-master
EXPOSE 3000

CMD ["/data/burstah-master/bin/www"]
