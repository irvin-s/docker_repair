FROM beatrak/node-base

RUN mkdir -p /root/app
RUN mkdir -p /root/common

WORKDIR /root/app

COPY ./app/ /root/app/
COPY ./common/ /root/common/

COPY ./start.sh /
RUN chmod a+x /start.sh
CMD ["/start.sh"]




