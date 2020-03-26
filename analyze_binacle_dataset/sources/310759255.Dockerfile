FROM node:8

# Create app directory
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
  uuid-dev \
  libevent-dev

COPY . .

RUN curl -o rtm.zip http://download.agora.io/rtmsdk/release/Agora_RTM_SDK_for_Linux_v0_9_2.zip && unzip rtm.zip -d /usr/src/rtm

RUN ls /usr/src/rtm -a

RUN mv /usr/src/rtm/Agora_RTM_SDK_for_Linux/libs/include /usr/src/app/agora-rtm-nodejs

RUN mv /usr/src/rtm/Agora_RTM_SDK_for_Linux/libs/libagora_rtm_sdk.so /usr/lib/

RUN cd /usr/src/app/agora-rtm-nodejs && npm install --ignore-scripts && npm run build:addon && npm run build:ts

RUN cd /usr/src/app && npm install && npm run prestart

EXPOSE 8080

CMD [ "node", "./dist/index.js" ]