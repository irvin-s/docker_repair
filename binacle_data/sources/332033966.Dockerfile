FROM willdurand/elk

LABEL maintainer="Webber Takken <webber@takken.io>"

COPY logstash/logstash.conf /etc/logstash
COPY logstash/patterns /opt/logstash/patterns

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]

ENV PATH /opt/logstash/bin:$PATH

EXPOSE 80
