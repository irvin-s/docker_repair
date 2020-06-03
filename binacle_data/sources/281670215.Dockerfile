FROM cse-jre:1.8
MAINTAINER wyuch@zving.com
WORKDIR /
COPY ./target/baseData-0.0.1-SNAPSHOT.war /
EXPOSE 8014
ENV sc="http://192.168.1.12:30100"
ENV cc="http://192.168.1.12:30103"
COPY ./start.sh /
RUN chmod 777 /start.sh
CMD ["/start.sh","baseData-0.0.1-SNAPSHOT.war"]