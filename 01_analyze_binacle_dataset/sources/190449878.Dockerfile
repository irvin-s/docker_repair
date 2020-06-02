FROM jongleberry/video:latest

ADD . /silence/
WORKDIR /silence/

RUN npm install
