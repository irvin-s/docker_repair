FROM cse-jre:1.8
MAINTAINER wyuch@zving.com
WORKDIR /
COPY ./target/riskAnalysis-0.0.1-SNAPSHOT.war /
EXPOSE 8007
ENV sc="http://192.168.1.12:30100"
ENV cc="http://192.168.1.12:30103"
COPY ./start.sh /
RUN chmod 777 /start.sh
CMD ["/start.sh","riskAnalysis-0.0.1-SNAPSHOT.war"]