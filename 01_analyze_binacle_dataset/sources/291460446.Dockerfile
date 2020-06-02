from node:boron

RUN npm install -g node-dtls-proxy

COPY udp2dtls.sh .

CMD ["/bin/bash","udp2dtls.sh"]



