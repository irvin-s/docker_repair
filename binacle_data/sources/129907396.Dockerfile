FROM beatrak/node-base

ENV PS1="[beatrak/beacon]# "

RUN mkdir -p /root/app
RUN mkdir -p /root/common

WORKDIR /root/app

COPY ./app/* /root/app/
COPY ./common/* /root/common/

WORKDIR /root/common
RUN npm install

WORKDIR /root/app
RUN npm install

EXPOSE 8080

CMD ["npm", "start"]



