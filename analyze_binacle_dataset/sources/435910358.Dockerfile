FROM node:boron

MAINTAINER avlidienbrunn

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install socat -y
RUN apt-get install psmisc -y

ENV APP_DIR /app/

WORKDIR $APP_DIR

ADD . $APP_DIR/

RUN cd $APP_DIR/

RUN rm -rf /app/node_modules/

RUN useradd -c 'jail user' -m -d /home/jailer -s /bin/bash jailer
RUN chmod 755 /app/jail.js
RUN chmod 600 /app/Dockerfile
RUN chmod 755 /app/run.sh
RUN chmod 755 /app/killall.sh
RUN chmod 755 /app/chall.sh
RUN chmod +x /app/run.sh
RUN chmod +x /app/chall.sh
RUN chmod +x /app/killall.sh

USER jailer

CMD ["/app/run.sh"]