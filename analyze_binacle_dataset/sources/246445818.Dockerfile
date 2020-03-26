FROM nginx

MAINTAINER 91yun https://www.91yunco

RUN apt-get update
RUN apt-get -y install gcc g++ make git
RUN git clone https://github.com/91yun/ServerStatus
RUN cp -rf /ServerStatus/web/* /usr/share/nginx/html/


WORKDIR /ServerStatus/server

RUN make

EXPOSE 80 3561

RUN chmod +x /ServerStatus/init.sh

ENTRYPOINT ["/ServerStatus/init.sh"]