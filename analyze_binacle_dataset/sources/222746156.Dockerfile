FROM ubuntu
MAINTAINER Thorsten Zoerner <me@thorsten-zoerner.com>
VOLUME ["/edichain"]
ADD ./install.sh /tmp/install.sh
ADD ./start.sh /tmp/start.sh
RUN chmod 777 /tmp/install.sh 
RUN /tmp/install.sh
CMD /tmp/start.sh
# ENTRYPOINT ["/tmp/start.sh"] 
EXPOSE 4001 5001 8000 8080 8088

