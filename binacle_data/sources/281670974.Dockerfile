FROM cse-jre:1.8
MAINTAINER wyuch@zving.com
WORKDIR /
COPY ./target/taxCutting-0.0.1-SNAPSHOT.war /
EXPOSE 8005
ENV sc="http://192.168.1.12:30100"
ENV cc="http://192.168.1.12:30103"
COPY ./start.sh /
RUN chmod 777 /start.sh
CMD ["/start.sh","taxCutting-0.0.1-SNAPSHOT.war"]