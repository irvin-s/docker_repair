FROM boomtownroi/base:latest

MAINTAINER BoomTown CNS Team <consumerteam@boomtownroi.com>

RUN mkdir /51Degrees
COPY 51Degrees-LiteV3.2.dat /51Degrees/51Degrees-LiteV3.2.dat
VOLUME /51Degrees
