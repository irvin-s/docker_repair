FROM logstash

COPY logstash.conf /
COPY cert-gen.sh /
RUN /cert-gen.sh localhost logging

CMD ["-f", "/logstash.conf", "--allow-env"]
