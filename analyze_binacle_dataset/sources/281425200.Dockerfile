FROM debian:jessie

ADD faketsdb /usr/local/bin
ADD entrypoint.sh /usr/local/bin/entrypoint.sh

RUN ln -s /usr/local/bin/faketsdb /faketsdb
RUN ln -s /usr/local/bin/entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/local/bin/faketsdb
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD [ "/entrypoint.sh" ]
