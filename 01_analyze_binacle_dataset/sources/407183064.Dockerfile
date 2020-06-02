FROM node:11

WORKDIR /usr/hsd

RUN apt-get update
RUN apt-get install libunbound-dev -y

RUN git clone https://github.com/handshake-org/hsd.git /usr/hsd

RUN npm install --production

RUN npm install github:HandshakeAlliance/hstratum

COPY ./run.sh run.sh

RUN sed -i -e 's/\r$//' run.sh

RUN chmod 0775 run.sh

WORKDIR /usr/hsd

EXPOSE 13037 13038 13039 3008

