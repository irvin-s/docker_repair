FROM lyft/envoy:latest

RUN apt-get update && apt-get -q install -y \
    curl

ARG MASHLING_NAME
ENV MASHLING_NAME=$MASHLING_NAME
ARG ROOT_DIR
ENV ROOT_DIR=$ROOT_DIR

RUN echo 'name=$MASHLING_NAME'
RUN echo $PWD

RUN mkdir /apps && mkdir /apps/$MASHLING_NAME && ls /apps

ADD $MASHLING_NAME /apps/$MASHLING_NAME

RUN ls -la /apps/$MASHLING_NAME

ADD start_http_mashling_service.sh /usr/local/bin/start_mashling_service.sh
RUN chmod u+x /usr/local/bin/start_mashling_service.sh
ENTRYPOINT /usr/local/bin/start_mashling_service.sh
