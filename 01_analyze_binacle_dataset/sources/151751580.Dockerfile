FROM mafintosh/base

RUN curl -fs https://raw.githubusercontent.com/mafintosh/node-install/master/install | sh; node-install 0.10.33;
RUN npm install -g npm-start@1.4.0 node-gyp@1.0.2 && node-gyp install
RUN echo README > /root/README.md; npm config set color always; npm config set unsafe-perm true; npm config set loglevel http

WORKDIR /root

ONBUILD ADD package.json /root/
ONBUILD RUN npm install 2>&1
ONBUILD ADD . /root/
ONBUILD RUN npm run build

ENTRYPOINT ["npm-start"]