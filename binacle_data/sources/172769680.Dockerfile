FROM node:0.10-slim
COPY config.js /
RUN npm install -g docker-dns
EXPOSE  53
CMD ["/usr/local/bin/docker-dns", "-c", "/config.js"]
