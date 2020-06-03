from node:boron

RUN npm install -g node-dtls-proxy

COPY dtls2udp.sh .

CMD ["/bin/bash","dtls2udp.sh"]

