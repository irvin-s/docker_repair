FROM node:boron

MAINTAINER avlidienbrunn

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install apt-transport-https
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update
RUN apt-get install google-chrome-stable -y
RUN apt-get install nano -y

ENV APP_DIR /app

WORKDIR $APP_DIR

ADD . $APP_DIR/

RUN cd $APP_DIR/

RUN rm -rf /app/node_modules

RUN npm install

RUN chmod +x run-service.sh

CMD ["/app/run-service.sh"]