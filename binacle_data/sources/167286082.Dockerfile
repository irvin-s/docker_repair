FROM ubuntu
ADD ./getip.sh /usr/src/getip.sh
RUN apt-get update && \
     apt-get install -y net-tools
RUN chmod +x /usr/src/getip.sh
CMD ["/usr/src/getip.sh"]
