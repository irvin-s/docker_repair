FROM node:9.2-stretch

RUN set -e -x ;\
    apt-get -y update ;\
    apt-get -y install protobuf-compiler ;\
    rm -rf /var/lib/apt/lists/*

ADD getline.ts /app/getline.ts
ADD pb /app/pb
WORKDIR /app/getline.ts

RUN set -e -x ;\
    yarn ;\
    yarn build
