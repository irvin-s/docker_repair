FROM alpine:edge
RUN apk update;apk add go git bash build-base || true
ENV GOPATH=/opt/go
RUN mkdir -p ${GOPATH}/src/github.com/elastic
WORKDIR ${GOPATH}/src/github.com/elastic
RUN git clone https://github.com/elastic/beats.git --depth=1
WORKDIR ${GOPATH}/src/github.com/elastic/beats/filebeat
RUN make
RUN ./filebeat modules enable system
RUN echo 'Log Test' > /var/log/syslog
RUN sed -i 's/localhost:9200/elasticsearch-master:9200/ig' filebeat.yml
RUN sed -i '/#host: "localhost:5601"/a host: \"kibana:5601\"' filebeat.yml
RUN sed -i 's/enabled: false/enabled: true/' filebeat.yml
RUN sed -i 's/*.log/*/' filebeat.yml
CMD ./filebeat setup;./filebeat -e run
