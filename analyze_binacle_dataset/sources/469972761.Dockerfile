FROM node:latest
WORKDIR /usr/src/app/
COPY package.json /usr/src/app/package.json
COPY vuex-bitshares/package.json vuex-bitshares/package.json
RUN (cd vuex-bitshares && npm install)
RUN npm install
# TO RUN FROM THIS STEP USE: --build-arg CACHEBUST=$(date +%s)
ARG CACHEBUST=1
COPY . /usr/src/app/
RUN npm run svg
ENTRYPOINT ["/bin/bash"]
CMD ["docker-entry.sh"]