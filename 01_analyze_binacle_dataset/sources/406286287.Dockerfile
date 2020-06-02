FROM python:2.7.15-stretch
 
WORKDIR /
RUN mkdir -p /root/PyOne /data/db /data/log /data/aria2/download && \
  touch /data/aria2/aria2.session
COPY PyOne/ /root/PyOne
COPY aria2.conf /data/aria2/

WORKDIR /root/PyOne/

RUN apt install curl -y && pip install -r requirements.txt && \
  cp self_config.py.sample self_config.py && \
  curl https://www.mongodb.org/static/pgp/server-3.6.asc | apt-key add - && \
  echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
  apt-get update && \
  apt-get install -y mongodb-org redis-server && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /	
COPY start.sh aria2c /
RUN mv aria2c /usr/local/bin && \
  chmod +x /start.sh /usr/local/bin/aria2c

EXPOSE 34567

ENTRYPOINT ["/start.sh"]
