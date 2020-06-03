FROM kibana:latest

RUN apt-get update && apt-get install -y apt-utils netcat

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

CMD ["/tmp/entrypoint.sh"]