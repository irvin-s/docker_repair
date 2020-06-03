FROM beatrak/node-base

RUN mkdir -p /root/app
RUN mkdir -p /root/common

ADD ./app /root/app
ADD ./common /root/common

WORKDIR /root/common
RUN npm install
WORKDIR /root/app
RUN npm install

EXPOSE 8080

CMD ["npm", "start"]



