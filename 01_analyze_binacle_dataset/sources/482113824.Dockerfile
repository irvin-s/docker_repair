FROM java:8-jre

MAINTAINER Yasong Yao "yaoyasong@gmail.com"

ENV ONE_PUSH_HOME /opt/one-push
RUN mkdir -p ${ONE_PUSH_HOME}
VOLUME ${ONE_PUSH_HOME}
WORKDIR ${ONE_PUSH_HOME}

COPY ./push-server.jar ${ONE_PUSH_HOME}/push-server.jar
COPY ./script/start-push-server.sh ${ONE_PUSH_HOME}/start-push-server.sh

EXPOSE 8080

CMD ["sh","start-push-server.sh"]
